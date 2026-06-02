# -- Theme --
romkatv/powerlevel10k

# -- Core Initialization --
# Runs compinit to enable completions. Must be loaded early.
~/.zsh/functions/compinit.plugin.zsh kind:defer

# -- Completion Definitions --
# Additional completion definitions.
zsh-users/zsh-completions kind:defer

# -- Oh My Zsh Libraries --
# History must not be deferred to ensure history is ready immediately.
ohmyzsh/ohmyzsh path:lib/history.zsh
ohmyzsh/ohmyzsh path:lib/theme-and-appearance.zsh kind:defer
ohmyzsh/ohmyzsh path:lib/git.zsh kind:defer
ohmyzsh/ohmyzsh path:lib/grep.zsh kind:defer
ohmyzsh/ohmyzsh path:lib/key-bindings.zsh kind:defer
ohmyzsh/ohmyzsh path:lib/completion.zsh kind:defer
ohmyzsh/ohmyzsh path:lib/functions.zsh kind:defer
ohmyzsh/ohmyzsh path:lib/misc.zsh kind:defer
ohmyzsh/ohmyzsh path:lib/correction.zsh kind:defer

# -- Oh My Zsh Plugins --
ohmyzsh/ohmyzsh path:plugins/git kind:defer
ohmyzsh/ohmyzsh path:plugins/history kind:defer
ohmyzsh/ohmyzsh path:plugins/bun kind:defer
ohmyzsh/ohmyzsh path:plugins/colored-man-pages kind:defer
ohmyzsh/ohmyzsh path:plugins/rust kind:defer
ohmyzsh/ohmyzsh path:plugins/fzf kind:defer

# -- Community Utilities --
paulirish/git-open kind:defer
wintermi/zsh-mise kind:defer
ajeetdsouza/zoxide kind:defer

# -- Enhancements & Visuals --
# Suggestions and Syntax Highlighting should be loaded last.
zsh-users/zsh-autosuggestions kind:defer
zdharma-continuum/fast-syntax-highlighting kind:defer

# -- Advanced Completion --
# fzf-tab replaces the standard completion menu.
Aloxaf/fzf-tab kind:defer

# -- Local Configuration --
~/.zsh/aliases/aliases.plugin.zsh kind:defer
~/.zsh/aliases/directories.plugin.zsh kind:defer
~/.zsh/functions/functions.plugin.zsh kind:defer
~/.zsh/functions/packer.plugin.zsh kind:defer
~/.zsh/config/completion_style.plugin.zsh kind:defer

# -- Debugging --
# Benchmark shell startup time.
# romkatv/zsh-bench kind:path
