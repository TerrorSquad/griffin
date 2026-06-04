update-antidote() {
    IS_ONLINE=$(ping -c 1 google.com)
    if [ $? -eq 0 ]; then
        echo "Updating antidote plugins"
        if [ $IS_MAC ]; then
            rm -rf ~/Library/Caches/antidote
        elif [ $IS_LINUX ]; then
            rm -rf ~/.cache/antidote
        fi
        antidote update
        antidote bundle <~/.zsh_plugins.sh >~/.zsh_plugins.zsh
    else
        echo "No internet connection"
    fi
}

getJiraTicketNumber() {
    local branchName=$(git branch --show-current)
    echo $branchName | grep -o -E '[A-Z]+-[0-9]+'
}

bench() {
    hyperfine 'zsh -i -c exit' --warmup 3
}

getProgramPids() {
    PROGRAM=$1
    local result=$(ps aux | grep ${PROGRAM} | grep -v grep | tr -s ' ' | cut -d ' ' -f 2)
    echo $result
}

kill_by_name() {
    PROGRAM=$1
    local PIDS=$(getProgramPids ${PROGRAM})
    if [ $PIDS ]; then
        echo ${PIDS} | xargs kill -9
        return $?
    else
        echo "PROGRAM IS STOPPED"
        return 1
    fi
}

kill_port() {
    if [ $# -eq 0 ]; then
        echo "No arguments provided"
        echo "provide port of service you wish to kill"
        exit 1
    fi
    fuser -k $1/tcp
}

if [[ $(uname -a) != *"Darwin"* ]]; then
    phpstorm() {
        nohup $HOME/.local/bin/phpstorm "$@" &>/dev/null &
        disown
    }
fi

sudohx() {
    sudo $(which hx) "$@"
}

sudonvim() {
    sudo $(which nvim) "$@"
}

sudosd() {
    sudo $(which sd) "$@"
}

restartPlasma() {
    kquitapp6 plasmashell || kstart plasmashell
}

update-vscode() {
    # 1. Define download URL and create a temporary file for the .deb package
    local DOWNLOAD_URL='https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
    local TEMP_DEB
    TEMP_DEB=$(mktemp /tmp/vscode-XXXXXX.deb)

    # 2. Trap mechanism to ensure cleanup of the temporary file on exit, interrupt, or termination
    trap 'rm -f "$TEMP_DEB"' EXIT INT TERM

    echo "=== [VS Code Update Setup] ==="

    # 3. Check for Linux and dpkg presence to ensure we're on a compatible Debian/Ubuntu-based system
    if [ "$(uname)" != "Linux" ] || ! command -v dpkg >/dev/null 2>&1; then
        echo "❌ Error: This script is strictly for Debian/Ubuntu-based Linux systems." >&2
        return 1
    fi

    # 4. Check for required dependencies (curl, sudo, apt-get) before proceeding
    local bin; for bin in curl sudo apt-get; do
        if ! command -v "$bin" >/dev/null 2>&1; then
            echo "❌ Error: Required dependency '$bin' is missing." >&2
            return 1
        fi
    done

    # 5. Download the latest stable VS Code .deb package with robust error handling
    # --fail: Fail on HTTP errors (npr. 404, 500)
    # --location: Follow redirects (301, 302)
    # --show-error --silent: Reduce output, but show error if it fails
    echo "⬇️ Downloading latest VS Code stable release..."
    if ! curl --fail --location --show-error --silent -o "$TEMP_DEB" "$DOWNLOAD_URL"; then
        echo "❌ Error: Download failed." >&2
        return 1
    fi

    # 6. Verify that the downloaded file is not empty or corrupted before attempting installation
    if [ ! -s "$TEMP_DEB" ]; then
        echo "❌ Error: Downloaded file is empty or corrupt." >&2
        return 1
    fi

    # 7. Install the downloaded .deb package using apt-get to ensure proper handling of dependencies
    echo "🚀 Installing package via apt-get (requires sudo)..."
    # --quiet: Reduce output, but still show errors
    # -y: Automatically answer 'yes' to prompts
    # Using apt-get instead of dpkg to ensure dependencies are resolved
    if ! sudo apt-get update -qq && sudo apt-get install -y "$TEMP_DEB"; then
        echo "❌ Error: Installation failed." >&2
        return 1
    fi

    echo "✅ VS Code updated successfully."
    return 0
}