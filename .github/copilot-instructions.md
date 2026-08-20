# GitHub Copilot Instructions

## Project Overview

Griffin is an Ansible-based automation project that transforms fresh Debian-based Linux systems and macOS into fully-configured development environments. It automates post-installation tasks for Ubuntu, Linux Mint, Debian, macOS, and WSL environments.

## Architecture & Core Components

### Execution Flow
1. **Main Entry Points**: `playbook.yaml` (Linux/WSL) and `playbook_macos.yaml` (macOS)
2. **Role Structure**: Single `post-installation` role with tasks organized by OS (`darwin`, `debian`) and `shared`
3. **Conditional Logic**: Feature flags (`all`, `gui`, `kde`, `remove_snap`, `dev_tools_gui`, etc.)
4. **Task Organization**: Modular tasks in `post-installation/tasks/` split into `darwin/`, `debian/`, and `shared/` directories

### Key Architectural Patterns

**Variable-Driven Configuration**: All paths, usernames, and features controlled via `defaults/main.yaml`:
```yaml
username: "{{ ansible_env.SUDO_USER | default(ansible_user_id) }}"
user_home: "/home/{{ username }}"
remove_snap: true  # Feature flag example
kde: true         # Desktop environment flag
```

**Configuration Sanitization**:
- Helper scripts (e.g., `import_kde_configs.sh`) MUST be used to import local configs.
- **Strict PII Content Removal**: Configs must be sanitized of:
  - Hardware UUIDs
  - Screen resolutions/geometries (e.g., `[ScreenMapping]`)
  - File history/Recent documents
  - User-specific paths or IDs
- Use `sed` in import scripts to enforce this automatically.

**Utility Task Pattern**: Reusable GitHub asset installer (`shared/utils/install_github_asset.yaml`) handles:
- Binary downloads to `/usr/local/bin/`
- Deb package installations 
- Tar.gz extraction with architecture filtering

**Homebrew Integration**: Uses `/home/linuxbrew/.linuxbrew/bin` path with `become_user: "{{ username }}"` pattern

## Critical Development Workflows

### Testing Command (matches CI):
```bash
# Linux
ansible-playbook ./playbook.yaml -K -e all=true

# macOS  
ansible-playbook ./playbook_macos.yaml -K -e all=true
```

### Running Against an Already-Provisioned Machine:
- `~/.zshrc` is overwritten from `defaults/.zshrc` on every run. Machine-specific
  exports belong in `~/.zshrc.local`, which it sources. A pre-existing `.zshrc`
  has its hand-added tail rescued into that file once, on first run.
- `nvim_reset=true` wipes `~/.vim/plugged` for a clean plugin reinstall. Off by
  default so a re-run does not destroy a working plugin set.

### Adding New Software:
1. Choose task file: `*_cli.yaml` vs `*_gui.yaml` vs dedicated file for complex installs
2. Add conditional inclusion to `main.yaml` or appropriate coordinator file
3. Use utility tasks for GitHub releases: `ansible.builtin.include_tasks: shared/utils/install_github_asset.yaml`

### CI Testing Strategy:
- Ubuntu 24.04 in GitHub Actions
- Full installation with `all=true` flag
- Triggered on `post-installation/**/*` path changes

## Project-Specific Conventions

### Task Naming & Structure:
```yaml
- name: Install dependencies  # Descriptive action-based names
  ansible.builtin.apt:          # Always use FQCN module names
    name:                       # Array format for multiple packages
      - apt-transport-https
```

### Error Handling Patterns:
```yaml
register: result
failed_when: false            # For optional installs
ignore_errors: true          # With explicit failure logging
retries: 3                   # For network operations
```

### User Context Management:
```yaml
become_user: "{{ username }}"  # For user-specific operations
become: true                   # Default for system operations
```

### GitHub Asset Installation:
```yaml
vars:
  github_repo: docker/compose
  github_asset: docker-compose
  type: binary|deb|tar.gz     # Controls extraction method
```

## Distribution-Specific Handling

- **Linux Mint**: Special `themes.yaml` and `dconf.yaml` tasks
- **WSL Detection**: Conditional `code` installation logic
- **Distribution Release**: Dynamic repository configuration using `{{ ansible_distribution_release }}`
- **macOS**: Uses Homebrew Cask for GUI apps, different paths (`/opt/homebrew` vs `/home/linuxbrew`)
- **Cross-Platform**: OS detection via `ansible_os_family` ('Darwin' for macOS, 'Debian' for Linux)

## Proxy/Corporate Environment Support

- Zscaler certificate handling via `add_zscaler_root_cert.sh`
- Certificate placement in `/usr/local/share/ca-certificates/`
- Always include proxy considerations for network operations

## Tool Inclusion Criterion

This repo is one developer's workstation. The test for keeping a tool is **"do I
actually use it?"**, not "might someone want it". Apply it on every change:

- A tool with no shell-history usage, no alias, no keybinding, and no git-config
  path belongs in a `*_optional` list — or nowhere.
- Prefer removing over adding. A dependency that pulls in a language runtime
  (Python, Node) must earn that weight; check `brew deps <formula>` before adding.
- If apt or mise already provides a tool, do not also install it via Homebrew.

`all=true` means "everything the author uses". `ci=true` means "every code path
worth exercising, cheaply". They are independent — never make one imply the other.

## Commit Conventions

This project follows [Conventional Commits](https://www.conventionalcommits.org/) specification:

### Commit Message Format:
```
<type>[optional scope]: <description>
```

**Note**: Use short commit messages without body text unless absolutely necessary for complex changes.

### Common Types:
- `feat`: New feature or functionality
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semicolons, etc.)
- `refactor`: Code refactoring without feature changes
- `test`: Adding or updating tests
- `ci`: CI/CD pipeline changes
- `chore`: Maintenance tasks, dependency updates

### Examples:
```
feat(docker): add docker-compose installation via GitHub releases
fix(homebrew): handle installation failures gracefully
docs: update usage examples in README
ci: add Ubuntu 24.04 to test matrix
feat: implement project improvements and check-mode compatibility
```

## Testing & Validation

### Manual Testing:
```bash
# CLI-only (servers/WSL)
ansible-playbook ./playbook.yaml -K

# Full GUI environment (Linux)
ansible-playbook ./playbook.yaml -K -e all=true

# macOS (elevated rights required)
ansible-playbook ./playbook_macos.yaml -K -e all=true
```

### Idempotency Requirements:
- All tasks must be safe to run multiple times
- Use `state: present/latest` appropriately
- Check for existing installations before proceeding
