# Post-Installation Role

This role handles the core logic for the Griffin automation suite. It is designed to be cross-platform (Linux/macOS) and modular.

## Variables

The role uses a split variable structure:
- `vars/debian.yaml`: Linux-specific paths and settings.
- `vars/darwin.yaml`: macOS-specific paths and settings.
- `defaults/main.yaml`: Common default settings and feature flags.

### Feature Flags

You can enable specific features by passing variables or using tags (see below).

| Variable | Default | Description |
|----------|---------|-------------|
| `gui` | `false` | Installs general GUI applications (browsers, chat apps, etc.) |
| `dev_tools_gui` | `false` | Installs GUI development tools (IDEs, DB clients) |
| `docker` | `false` | Installs Docker and Docker Compose |
| `ddev` | `false` | Installs DDEV local development environment |
| `rust` | `false` | Installs Rust toolchain |
| `golang` | `false` | Installs Go toolchain |
| `fonts` | `false` | Installs Nerd Fonts |
| `all` | `false` | Enables ALL features |

## Tags

Tags allow you to run specific parts of the playbook. Using a tag automatically enables the corresponding feature flag.

| Tag | Description | Implied Variable |
|-----|-------------|------------------|
| `system` | System preparation (apt update, basic packages) | - |
| `homebrew` | Install and configure Homebrew | - |
| `packages` | Same as homebrew | - |
| `shell` | Shell configuration (zsh, Oh My Zsh, Powerlevel10k) | - |
| `zsh` | Same as shell | - |
| `dotfiles` | Same as shell | - |
| `dev` | Development foundation (git config, neovim) | - |
| `git` | Same as dev | - |
| `editors` | Same as dev | - |
| `languages` | Programming languages (requires language flags) | - |
| `programming` | Same as languages | - |
| `rust` | Rust installation | `rust=true` |
| `golang` | Go installation | `golang=true` |
| `dev-tools` | Development tools container | - |
| `docker` | Docker installation | `docker=true` |
| `ddev` | DDEV installation | `ddev=true` |
| `fonts` | Fonts installation | `fonts=true` |
| `gui` | GUI applications | `gui=true` |
| `cleanup` | Final cleanup tasks | - |

### Example Usage

Run only shell configuration:
```bash
ansible-playbook playbook.yaml -K --tags "shell"
```

Install only Rust and Go:
```bash
ansible-playbook playbook.yaml -K --tags "rust,golang"
```

## Directory Structure

- `tasks/`: Main task definitions
  - `debian/`: Linux-specific tasks
  - `darwin/`: macOS-specific tasks
  - `shared/`: Cross-platform tasks
- `vars/`: OS-specific variable definitions
- `defaults/`: Default variable values
- `handlers/`: Event handlers (e.g., cache updates)

## Retry Strategy & Error Handling

This playbook employs a **"Fail Fast with Retries"** strategy:

1.  **Network Operations**: Tasks involving downloads (Homebrew, GitHub assets, Fonts) are configured with `retries: 3` (or 5) and `delay: 2` (or 10) to handle transient network issues.
2.  **Fail Fast**: If retries are exhausted, the task fails, and the playbook stops execution immediately. This ensures the system is not left in an inconsistent state.
3.  **Reporting**: GUI application tasks are wrapped in `block/always` structures. This ensures that even if the installation fails (triggering a playbook stop), the "Installation Summary" is printed first, showing exactly which apps succeeded and which one failed.

### Known Limitations

**"Retry Storm" in GUI Tasks**:
For macOS GUI applications (`dev_tools_gui.yaml`, `general_use_software_gui.yaml`), we use `loop` combined with `until/retries`.
- **Behavior**: If item #10 fails, Ansible retries the *entire loop* from item #1.
- **Reason**: This structure is maintained to populate the `register` variable with individual results for the detailed "Installation Summary".
- **Mitigation**: Homebrew Cask is idempotent and fast for already-installed apps, so the re-check overhead is minimal.
