# Griffin: Effortless Cross-Platform Configuration

[![Ubuntu](https://github.com/TerrorSquad/griffin/actions/workflows/ubuntu.yaml/badge.svg)](https://github.com/TerrorSquad/griffin/actions/workflows/ubuntu.yaml)
[![WSL](https://github.com/TerrorSquad/griffin/actions/workflows/wsl.yaml/badge.svg)](https://github.com/TerrorSquad/griffin/actions/workflows/wsl.yaml)
[![macOS](https://github.com/TerrorSquad/griffin/actions/workflows/macos.yaml/badge.svg)](https://github.com/TerrorSquad/griffin/actions/workflows/macos.yaml)

## Overview

Griffin is an Ansible playbook designed to automate the installation and configuration of software on both Linux and macOS systems, making cross-platform post-installation tasks a breeze.

## Key Features

* **Automates Post-Installation Tasks:** Configure system settings, install packages, and perform other common tasks.
* **Ensures Consistency:** Maintain uniform configuration across multiple systems.
* **Highly Customizable:** Easily modify playbooks to meet your specific needs.

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
