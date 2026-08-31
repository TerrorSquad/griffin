# Debian-Based System Tasks

This directory contains Ansible tasks that are specific to Debian-based systems (Ubuntu, Linux Mint, Debian).

## Organization:

### Core System Files:
- `system_setup.yaml` - System preparation (apt update, upgrade, system prerequisites)

### GUI and Applications:
- `gui_applications.yaml` - GUI applications coordinator
- `dev_tools_gui.yaml` - GUI development tools
- `general_use_software_gui.yaml` - General GUI applications

### System Customization:

### Infrastructure:
- `clean_apt.yaml` - APT cache cleanup

## Platform Requirements:
- Debian-based Linux distributions (Ubuntu, Linux Mint, Debian)
- APT package manager
- Systemd init system
