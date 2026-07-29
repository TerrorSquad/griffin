#!/bin/bash
set -e

# Configuration
SOURCE_DIR="$HOME/.claude"
DEST_DIR="post-installation/files/claude"

# Config only. Everything else in ~/.claude is state (projects/, sessions/,
# history.jsonl, plugins/, cache/) and must never be committed.
FILES=(
    "settings.json" # Model, hooks, statusline, enabled plugins
    "statusline.sh" # Custom status line script
)
# skills/ is deliberately excluded: it is plugin- and marketplace-managed, and
# the SKILL.md files reference personal project paths.
DIRS=(
    "hooks" # User-level hook scripts
)

setup_directory() {
    if [ ! -d "$DEST_DIR" ]; then
        echo "Creating directory: $DEST_DIR"
        mkdir -p "$DEST_DIR"
    fi
}

copy_files() {
    echo "Importing Claude Code configuration..."
    echo "Source: $SOURCE_DIR"
    echo "Destination: $DEST_DIR"
    echo "----------------------------------------"

    local count=0
    for file in "${FILES[@]}"; do
        if [ -f "$SOURCE_DIR/$file" ]; then
            cp "$SOURCE_DIR/$file" "$DEST_DIR/"
            echo "✅ Copied: $file"
            count=$((count + 1))
        else
            echo "⚠️  Skipped (not found): $file"
        fi
    done

    for dir in "${DIRS[@]}"; do
        if [ -d "$SOURCE_DIR/$dir" ]; then
            rm -rf "${DEST_DIR:?}/$dir"
            cp -R "$SOURCE_DIR/$dir" "$DEST_DIR/"
            echo "✅ Copied: $dir/ ($(find "$DEST_DIR/$dir" -type f | wc -l | tr -d ' ') files)"
            count=$((count + 1))
        else
            echo "⚠️  Skipped (not found): $dir/"
        fi
    done

    echo "----------------------------------------"
    echo "Import complete. $count entries copied."
}

sanitize_settings() {
    local file="$DEST_DIR/settings.json"
    [ ! -f "$file" ] && return

    echo "  - settings.json -> settings.json.j2"

    # Absolute home paths become an Ansible variable, so the config is portable.
    # ponytail: sed over jq - the only PII here is the home path, and sed keeps
    # {{ user_home }} out of jq's string escaping.
    sed "s|$HOME|{{ user_home }}|g" "$file" >"$file.j2"
    rm "$file"

    # Drop permissions entirely - grants leak repo layout, and leaving the key
    # out means the deploy merge never touches whatever is on the target machine.
    if command -v jq >/dev/null 2>&1; then
        jq 'del(.permissions, .hooks)' "$file.j2" >"$file.j2.tmp" && mv "$file.j2.tmp" "$file.j2"
    else
        echo "    ⚠️  jq not found - permissions.allow left in place, review manually"
    fi
}

# GNU and BSD sed disagree on -i. Pick the right one once.
sed_inplace() {
    if sed --version >/dev/null 2>&1; then
        sed -i "$@"
    else
        sed -i '' "$@"
    fi
}

sanitize_dirs() {
    for dir in "${DIRS[@]}"; do
        [ ! -d "$DEST_DIR/$dir" ] && continue

        echo "  - $dir/"
        # Skills and hooks reference absolute project paths; strip the home
        # prefix so the username never lands in git.
        find "$DEST_DIR/$dir" -type f -exec grep -Il "$HOME" {} + 2>/dev/null |
            while read -r f; do sed_inplace "s|$HOME|\$HOME|g" "$f"; done
    done
    chmod +x "$DEST_DIR/hooks"/* 2>/dev/null || true
}

check_leftovers() {
    echo "----------------------------------------"
    echo "🔍 Scanning for leftover personal data..."

    local hits
    hits=$(grep -rIl -e "$HOME" -e "$(whoami)" "$DEST_DIR" 2>/dev/null || true)
    if [ -n "$hits" ]; then
        echo "⚠️  Home path or username still present in:"
        echo "${hits//$'\n'/$'\n'     }" | sed '1s/^/     /'
        echo "     Review these before committing."
    else
        echo "✅ No home paths or usernames found."
    fi

    # Anything that looks like a credential is a hard stop. Patterns require a
    # full-length key body so docs that merely describe key formats don't trip it.
    local secrets='sk-ant-[A-Za-z0-9_-]{24,}|ghp_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{40,}|AKIA[0-9A-Z]{16}[^]A-Za-z0-9]'
    if grep -rIlE "$secrets" "$DEST_DIR" 2>/dev/null | grep -q .; then
        echo "🛑 Possible credential found - do NOT commit:"
        grep -rIlE "$secrets" "$DEST_DIR" | sed 's/^/     /'
        exit 1
    fi
    echo "✅ No credential patterns found."
}

sanitize_configs() {
    echo "----------------------------------------"
    echo "🧹 Sanitizing configuration files..."

    sanitize_settings
    sanitize_dirs

    echo "✨ Sanitization complete."
}

# Main execution
setup_directory
copy_files
sanitize_configs
check_leftovers
