# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -- Environment Variables --
ZSH_CACHE_DIR=$HOME/.zsh
HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"

export BAT_PAGER="less --mouse -RF"
export LESS="--mouse -RF"
export FZF_TMUX_HEIGHT=50

# -- Platform Specifics --
[[ $OSTYPE == darwin* ]] && IS_MAC=1
if [[ -n $IS_MAC ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
fi
unset IS_MAC

# -- Path & Fpath Configuration --
# Prepend to PATH so local/brew tools override system versions
path=(
    $HOME/.local/bin
    $HOMEBREW_PREFIX/bin
    $path
)
# Automatically remove duplicate entries from PATH
typeset -U path

# Add custom completions to fpath
fpath=(
    $HOME/.zsh/completions
    $HOMEBREW_PREFIX/share/zsh/site-functions
    $fpath
)

# -- Antidote Plugin Manager --
source ${HOMEBREW_PREFIX}/opt/antidote/share/antidote/antidote.zsh

# Check if the plugins file is older than the sh file and regenerate it if needed
zsh_plugins=~/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.sh ]]; then
  antidote bundle <${zsh_plugins}.sh >${zsh_plugins}.zsh
fi

# Load the plugins
source ${zsh_plugins}.zsh

# -- Editor --
if (( $+commands[nvim] )); then
  export EDITOR=nvim
  export VISUAL=nvim
fi

# -- Options --
# Disable double rm -rf verification.
setopt rm_star_silent
# Don't record commands that start with a space
setopt HIST_IGNORE_SPACE

if [[ -s /usr/local/share/ca-certificates/ZscalerRootCA.crt ]]; then
    export NODE_EXTRA_CA_CERTS="/usr/local/share/ca-certificates/ZscalerRootCA.crt"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Local, machine-specific config. Not managed by Ansible - put your own exports here.
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
