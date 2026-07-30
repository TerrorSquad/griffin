#!/bin/bash
set -e

# Configuration
SOURCE_DIR="$HOME/.claude"
DEST_DIR="post-installation/files/claude"

# Config only. Everything else in ~/.claude is state (projects/, sessions/,
# history.jsonl, plugins/, cache/) and must never be committed.
# skills/ and hooks/ are deliberately excluded: skills are plugin- and
# marketplace-managed, and both reference personal project paths.
FILES=(
    "settings.json" # Model, statusline, enabled plugins
    "statusline.sh" # Custom status line script
)

# Stripping permissions/hooks is the whole point of this script, and only jq can
# do it. Bail before touching anything rather than committing an unsanitized file.
require_jq() {
    command -v jq >/dev/null 2>&1 && return
    echo "🛑 jq not found - cannot strip permissions/hooks from settings.json. Install jq and re-run."
    exit 1
}

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

    # Drop permissions and hooks entirely - grants leak repo layout, and leaving
    # the keys out means the deploy merge never touches the target machine's own.
    jq 'del(.permissions, .hooks)' "$file.j2" >"$file.j2.tmp" && mv "$file.j2.tmp" "$file.j2"
}

check_leftovers() {
    echo "----------------------------------------"
    echo "🔍 Scanning for leftover personal data..."

    # Same hard stop as credentials: a username in git is a leak, not a warning.
    local hits
    hits=$(grep -rIl -e "$HOME" -e "$(whoami)" "$DEST_DIR" 2>/dev/null || true)
    if [ -n "$hits" ]; then
        echo "🛑 Home path or username still present in:"
        echo "${hits//$'\n'/$'\n'     }" | sed '1s/^/     /'
        echo "     Sanitize these before committing."
        exit 1
    fi
    echo "✅ No home paths or usernames found."

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

    echo "✨ Sanitization complete."
}

# Main execution
require_jq
setup_directory
copy_files
sanitize_configs
check_leftovers
