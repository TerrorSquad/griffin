# Griffin: Effortless Cross-Platform Configuration

[![Ubuntu](https://github.com/TerrorSquad/griffin/actions/workflows/ubuntu.yaml/badge.svg)](https://github.com/TerrorSquad/griffin/actions/workflows/ubuntu.yaml)
[![WSL](https://github.com/TerrorSquad/griffin/actions/workflows/wsl.yaml/badge.svg)](https://github.com/TerrorSquad/griffin/actions/workflows/wsl.yaml)
[![macOS](https://github.com/TerrorSquad/griffin/actions/workflows/macos.yaml/badge.svg)](https://github.com/TerrorSquad/griffin/actions/workflows/macos.yaml)

## Overview

Griffin is one developer's Linux and macOS workstation, expressed as an Ansible playbook. It turns a fresh install into a working environment in a single command.

It is published because it is useful to read and fork, not because it is a general-purpose provisioner. The tool choices, dotfiles, and desktop tweaks are opinionated and personal — expect to remove things you don't want.

## Key Features

* **One command, whole machine:** Shell, CLI tooling, languages, containers, and desktop config in a single run.
* **Idempotent:** Safe to re-run. Re-running is the intended way to update an existing machine.
* **Modular:** Feature flags and tags let you install only the parts you want.
* **Cross-platform:** The same role covers Ubuntu, Mint, Debian, WSL, and macOS.

## Forking

The fastest path to your own setup:

1. Edit `tool_sets` in `post-installation/defaults/main.yaml` — that's the single source of truth for what gets installed.
2. Replace the dotfiles in `post-installation/defaults/` with your own.
3. Run `ansible-playbook ./playbook.yaml -K` and iterate.

## Supported Platforms

### Linux
- **Ubuntu** 24.04 LTS
- **Linux Mint** (latest versions)
- **Debian** (latest stable)
- **WSL** (Windows Subsystem for Linux)

### macOS
- **macOS** 12+ (Monterey and newer)
- **Intel** and **Apple Silicon** Macs
- **Homebrew** as the primary package manager
- **Admin privileges** required for some installations (use `-K` flag)

## Get Started

For detailed installation instructions, usage guides, and FAQs, please refer to our comprehensive documentation:

[**https://terrorsquad.github.io/griffin/**](https://terrorsquad.github.io/griffin/)

## License

This project is licensed under the [MIT License](LICENSE.md).
