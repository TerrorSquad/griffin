# macOS (Darwin) System Tasks

This directory contains Ansible tasks that are specific to macOS systems.

## Organization:

### Core System Files:
- `system_setup.yaml` - System preparation (Xcode Command Line Tools, download directory)

### GUI and Applications:
- `gui_applications.yaml` - GUI applications coordinator
- `dev_tools_gui.yaml` - GUI development tools
- `general_use_software_gui.yaml` - General GUI applications

### Infrastructure:

## Platform Requirements:
- macOS (Darwin)
- Homebrew package manager
- Homebrew Cask for GUI applications

## Notes:
- Most installations use Homebrew and Homebrew Cask
- User-level installations (no sudo required for most packages)
- Different paths: `/opt/homebrew` (Apple Silicon) or `/usr/local` (Intel)
