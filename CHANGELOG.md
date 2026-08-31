# Changelog

## [2.12.0](https://github.com/TerrorSquad/griffin/compare/v2.11.0...v2.12.0) (2026-08-31)


### Features

* separate ci flag from all, cover the default install path, unbreak CI ([#52](https://github.com/TerrorSquad/griffin/issues/52)) ([61f93f9](https://github.com/TerrorSquad/griffin/commit/61f93f9db4b2deb1f9312e2546980d9166e36c3d))

## [2.11.0](https://github.com/TerrorSquad/griffin/compare/v2.10.2...v2.11.0) (2026-08-17)


### Features

* **gui:** opt-in Viber, gate heavy GUI apps behind `all`, add flag picker ([#49](https://github.com/TerrorSquad/griffin/issues/49)) ([9111d70](https://github.com/TerrorSquad/griffin/commit/9111d70dba858128ef5be2db31a5afe298f1d0f0))

## [2.10.2](https://github.com/TerrorSquad/griffin/compare/v2.10.1...v2.10.2) (2026-08-05)


### Bug Fixes

* point every URL at the renamed griffin repo ([#47](https://github.com/TerrorSquad/griffin/issues/47)) ([9cb6172](https://github.com/TerrorSquad/griffin/commit/9cb617230c02bdf0ce7370d9ea85765d0d9d9f33))

## [2.10.1](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.10.0...v2.10.1) (2026-07-31)


### Bug Fixes

* **git:** drop task copying the deleted .git-templates-sample ([#42](https://github.com/TerrorSquad/ansible-post-installation/issues/42)) ([3710784](https://github.com/TerrorSquad/ansible-post-installation/commit/371078478c87665588d288cf4c095251e4174b2d))
* **macos:** repair silent cask failures, replace Gatekeeper-rejected apps ([#45](https://github.com/TerrorSquad/ansible-post-installation/issues/45)) ([d4f1f9f](https://github.com/TerrorSquad/ansible-post-installation/commit/d4f1f9f4082514f9cc7b84e011ac92a7ca1a434f))
* make a re-run non-destructive on an already-provisioned machine ([#43](https://github.com/TerrorSquad/ansible-post-installation/issues/43)) ([068a1d2](https://github.com/TerrorSquad/ansible-post-installation/commit/068a1d2cc95a79cc97ca40553a7c74418246c835))

## [2.10.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.9.0...v2.10.0) (2026-07-30)


### Features

* Claude Code support and macOS tool set overhaul ([#39](https://github.com/TerrorSquad/ansible-post-installation/issues/39)) ([d917915](https://github.com/TerrorSquad/ansible-post-installation/commit/d917915fbd49156bda99738d1471a9cbed955e1e))


### Bug Fixes

* **ddev:** satisfy ansible-lint production profile ([#40](https://github.com/TerrorSquad/ansible-post-installation/issues/40)) ([c0eb741](https://github.com/TerrorSquad/ansible-post-installation/commit/c0eb7415c41dec01f24a8ab1afc1d6e967aa407c))

## [2.9.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.8.0...v2.9.0) (2026-06-04)


### Features

* add update-vscode function ([bfdb724](https://github.com/TerrorSquad/ansible-post-installation/commit/bfdb7241a11ba988ab04e65b9242ac24eaa95a06))


### Bug Fixes

* remove zsh command-not-found plugin ([f433b36](https://github.com/TerrorSquad/ansible-post-installation/commit/f433b36e6b6a920f4cb5f5cf5a1c2a5f1c64f284))
* update clipboard copy functionality and enhance b85 archive handling ([e0e08d3](https://github.com/TerrorSquad/ansible-post-installation/commit/e0e08d3da3b0ef6e559e64b577ebdbeea0fd3d78))

## [2.8.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.7.0...v2.8.0) (2026-02-23)


### Features

* --dry-run, --level, sensitive-file warnings, unpack count, list summary ([6d877a0](https://github.com/TerrorSquad/ansible-post-installation/commit/6d877a0daa35b1fe4f7d1714ee1c2fc52eeabe9f))
* --force collision guard, pv progress on decrypt ([5231d96](https://github.com/TerrorSquad/ansible-post-installation/commit/5231d965457ce04aa9fa11ea1f9e9f307e0f115a))
* add fastfetch and lazygit to tool sets; implement distro base detection task ([283997a](https://github.com/TerrorSquad/ansible-post-installation/commit/283997afc36ff228e879c00f52839bb36e3885bd))
* add task to fix Google Chrome duplicate repository entries ([06c539b](https://github.com/TerrorSquad/ansible-post-installation/commit/06c539b460d7292cb3d83736eab3b988978eff12))
* chmod 700 workspace, --verify, pv on decode, tar array fix, test suite ([1ab4771](https://github.com/TerrorSquad/ansible-post-installation/commit/1ab4771df94e5a2f680dd96dede029afe9241df3))
* logs to stderr, output size, unpack dir, --name flag, py error handling ([3583aa5](https://github.com/TerrorSquad/ansible-post-installation/commit/3583aa5859270014bc3563df71c5f00686718f86))
* **packer:** add secure_list, zsh completions, and input hardening ([ea5decd](https://github.com/TerrorSquad/ansible-post-installation/commit/ea5decdc3b995a029448c299bca74425ef62f6ab))
* **packer:** honour .gitignore patterns during rsync ([c625b87](https://github.com/TerrorSquad/ansible-post-installation/commit/c625b874d10afac6b914a7354723e4e5efc2c864))
* subshell encrypt/decrypt, pre-pack summary, secure_list --long, fix completion globs ([a712522](https://github.com/TerrorSquad/ansible-post-installation/commit/a712522c3f53ab73e548e097777b6dc6c56d9750))
* update modern CLI tool set with additional utilities ([2ad8485](https://github.com/TerrorSquad/ansible-post-installation/commit/2ad84856a0bc57f805b875d53576d92718ffc13d))
* **vscode:** add autoApprove setting for chat tools terminal ([97f708b](https://github.com/TerrorSquad/ansible-post-installation/commit/97f708b0ad7422898315885d7c829310e73c9e50))
* **zsh:** add secure archive utility functions for packing and unpacking ([1ef9dd5](https://github.com/TerrorSquad/ansible-post-installation/commit/1ef9dd5042c4fc6916fbdb09f30fa6ae498b8da2))


### Bug Fixes

* ensure correct working directory for mise installation in documentation workflow ([b754f7e](https://github.com/TerrorSquad/ansible-post-installation/commit/b754f7ef7cc8fc7bf1de482cc7a0cb81e71e1588))
* **packer:** exclude .data dir, improve split unpack robustness ([dce2d13](https://github.com/TerrorSquad/ansible-post-installation/commit/dce2d13066ac665e0f2de00b6f1f76b72eefa87c))
* **packer:** harden work_dir, dep checks, and edge cases ([bbd5d2e](https://github.com/TerrorSquad/ansible-post-installation/commit/bbd5d2eec2b47244d4f2c467bc48850aac69a60e))
* **packer:** validate --size early, rename SA_PASS, fix help text ([669f499](https://github.com/TerrorSquad/ansible-post-installation/commit/669f499caac62ada7a7b04e01cf7e126944d782e))
* shasum portability, /dev/tty prompts, secure_list checksum, NO_COLOR ([5534d52](https://github.com/TerrorSquad/ansible-post-installation/commit/5534d521ce1483500dfb7d73d657136501dfe4e1))
* update Google Chrome repository cleanup to handle duplicates ([483908e](https://github.com/TerrorSquad/ansible-post-installation/commit/483908ed4b19c0d0fd70140549bea813022c5d9a))
* **zsh:** update encryption methods to use environment variable for password ([aefb5bc](https://github.com/TerrorSquad/ansible-post-installation/commit/aefb5bc56d6d304a2bfdb11b60c4f9c0f7d14149))

## [2.7.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.6.0...v2.7.0) (2026-01-19)


### Features

* **kde:** add weather applets with configuration options ([b7a1b83](https://github.com/TerrorSquad/ansible-post-installation/commit/b7a1b83da6c0a3aef44df745a9ffadcf7b1f7bcb))
* remove atuin from CLI tools and tool sets ([5dbb2eb](https://github.com/TerrorSquad/ansible-post-installation/commit/5dbb2eb3b09d30432e88663bdef4b9a4da692b32))

## [2.6.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.5.1...v2.6.0) (2026-01-12)


### Features

* **kde:** add KDE customization support with configuration files and tasks ([afe3bb0](https://github.com/TerrorSquad/ansible-post-installation/commit/afe3bb04feb2d673716ef22de670c816d7e4c927))
* **snap:** add task to remove snap if configured in defaults ([387921a](https://github.com/TerrorSquad/ansible-post-installation/commit/387921a13a74d2fc37f2d904d08d71d1bc096349))
* **zshrc:** add VSCode shell integration for improved terminal experience ([63b2b65](https://github.com/TerrorSquad/ansible-post-installation/commit/63b2b65fddfc5d8ee15514eabc6afdfcd6d8ce41))

## [2.5.1](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.5.0...v2.5.1) (2026-01-11)


### Bug Fixes

* **cfg:** revert stdout_callback to default for compatibility ([c2acb61](https://github.com/TerrorSquad/ansible-post-installation/commit/c2acb61a7a63bec80c96fc10feebaeceb7504728))

## [2.5.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.4.3...v2.5.0) (2026-01-10)


### Features

* **docs:** enhance 'What's Installed' documentation with additional tools and utilities ([a7870dd](https://github.com/TerrorSquad/ansible-post-installation/commit/a7870dd4948744b56e90ce8e5b06291f12bcfac9))
* **docs:** modernize docs with docus 5 ([f65aa29](https://github.com/TerrorSquad/ansible-post-installation/commit/f65aa29eac59cc746cc5d081b9d32cae9141c58b))
* enhance software installation tasks with version checks and improved package management ([f1f8e94](https://github.com/TerrorSquad/ansible-post-installation/commit/f1f8e94b3e5a67e278d4a05e7b09e0766b888387))
* **zsh:** add configuration files and directory setup for Zsh ([34bba3c](https://github.com/TerrorSquad/ansible-post-installation/commit/34bba3ce25e82926ab48d3ef6710e1357bfeda6c))


### Bug Fixes

* **dev_tools:** separate terminal installations for GNOME/GTK and KDE environments ([4cf7409](https://github.com/TerrorSquad/ansible-post-installation/commit/4cf7409c0b1ef7183f7e153df0ada205b991a56f))
* **docs:** correct LinkedIn social link configuration in app config ([131981c](https://github.com/TerrorSquad/ansible-post-installation/commit/131981cd1fe3b1c8bdd18836de94d563602c6ae8))
* **docs:** update badge colors for terminal emulators and productivity tools in installation documentation ([ff73826](https://github.com/TerrorSquad/ansible-post-installation/commit/ff7382663b0d02b52caa7e7296a981491a876be2))
* remove username parameter from playbook commands to use environment variable instead ([5bc9753](https://github.com/TerrorSquad/ansible-post-installation/commit/5bc9753cf15d1a89389eba138a46799ee7673db2))
* update stdout callback to use YAML format and enable task profiling ([bb2ab69](https://github.com/TerrorSquad/ansible-post-installation/commit/bb2ab69c19f6ff27e9d4837a08ba2bc696ae1c06))
* **zsh:** disable async mode to prevent cursor flickering in Konsole/Yakuake and add Atuin, Zoxide, and Fastfetch to tool sets ([17ace1b](https://github.com/TerrorSquad/ansible-post-installation/commit/17ace1b7dc7493171e59101436759e9086c8a95f))

## [2.4.3](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.4.2...v2.4.3) (2026-01-09)


### Bug Fixes

* **ddev:** improve DDEV GPG key handling and mkcert configuration ([285130d](https://github.com/TerrorSquad/ansible-post-installation/commit/285130da0ee5e220894f34f4e0df1b3a20a1fe45))
* **dev_tools:** update Sublime Text installation process and add GPG key handling ([962dd5e](https://github.com/TerrorSquad/ansible-post-installation/commit/962dd5e4bce2c517adebd8a97160f192403d27b0))
* **homebrew:** ensure Homebrew directory is created with correct permissions ([fb76a92](https://github.com/TerrorSquad/ansible-post-installation/commit/fb76a927a66f495ee9960243f3d5fb994f6ff8a3))
* use sudo.ws for ubuntu 25.10 ([fe4476d](https://github.com/TerrorSquad/ansible-post-installation/commit/fe4476d857386e7bc56665af56ded469b387880b))

## [2.4.2](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.4.1...v2.4.2) (2025-12-04)


### Bug Fixes

* **gitconfig:** add missing sections and improve configuration clarity ([51809e5](https://github.com/TerrorSquad/ansible-post-installation/commit/51809e54557d045b80003b5e46506359f78439b9))
* **gitconfig:** remove init section for cleaner configuration ([fa1b4e0](https://github.com/TerrorSquad/ansible-post-installation/commit/fa1b4e03008c7fa74397248d7e33fd77cb816db5))
* **zshrc:** remove bat alias and unalias for macOS compatibility ([63842a7](https://github.com/TerrorSquad/ansible-post-installation/commit/63842a7bc28bc8a1c3372fa3226b8be374b8c2f9))

## [2.4.1](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.4.0...v2.4.1) (2025-11-23)


### Bug Fixes

* **fonts:** add checks for downloaded Nerd Fonts and improve error handling ([5116d41](https://github.com/TerrorSquad/ansible-post-installation/commit/5116d417a14f53419a8781d4a62bbead58befeb5))

## [2.4.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.3.1...v2.4.0) (2025-11-20)


### Features

* **docker:** add GPG key management for Docker installation ([238ec25](https://github.com/TerrorSquad/ansible-post-installation/commit/238ec25f05b86358d0b97b601448b1f0ef7b7d45))


### Bug Fixes

* **macos:** handle pre-installed Homebrew Cask apps gracefully ([9455e2c](https://github.com/TerrorSquad/ansible-post-installation/commit/9455e2c64f551cf85515be996cdf6cfb7722d8ee))
* update include_tasks syntax and apply tags for better organization ([71ef794](https://github.com/TerrorSquad/ansible-post-installation/commit/71ef7942d7b77cc34e8bfd0f9c4bb18e5276744a))

## [2.3.1](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.3.0...v2.3.1) (2025-11-20)


### Bug Fixes

* improve reliability, configuration, and documentation ([915a53c](https://github.com/TerrorSquad/ansible-post-installation/commit/915a53cde65c11beac3a3e54a168a308cd8b3524))

## [2.3.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.2.2...v2.3.0) (2025-11-16)


### Features

* add Homebrew installation, update, and upgrade tasks for Debian ([3e7c6fd](https://github.com/TerrorSquad/ansible-post-installation/commit/3e7c6fda5151ca5ae29678c02a5750555fa4c2b6))
* replace volta with mise ([7c7f0dc](https://github.com/TerrorSquad/ansible-post-installation/commit/7c7f0dc5c00d7c6ece36927f6ead6ecd9f5b978b))


### Bug Fixes

* ensure boolean evaluations in conditions (ansible 12 compat) ([b004632](https://github.com/TerrorSquad/ansible-post-installation/commit/b00463294eac45a096b4069c5822af5e18e7334b))
* remove HOMEBREW_CASK_OPTS to prevent quarantine issues ([d1e04e4](https://github.com/TerrorSquad/ansible-post-installation/commit/d1e04e445e390efe9686e850c848b0f856dc65ce))
* remove Ubuntu 22.04 references ([c54af71](https://github.com/TerrorSquad/ansible-post-installation/commit/c54af71b35d39fee9eb36d28979cd6fcece1aece))
* remove unused applications from installation list ([a6d176a](https://github.com/TerrorSquad/ansible-post-installation/commit/a6d176a258ea0cb8b08912b4e4251364fc609040))
* simplify job configuration by removing matrix strategy for OS ([7ef1882](https://github.com/TerrorSquad/ansible-post-installation/commit/7ef18827d10aa2fbf683ea70dc30c6c37aaa3077))
* update font download and extraction paths to use download_dir variable ([a6db4be](https://github.com/TerrorSquad/ansible-post-installation/commit/a6db4beaa3ad35a6de6166d90aeaf8199ee22ea0))
* update installation tasks to include sudo password and improve summary output ([2619291](https://github.com/TerrorSquad/ansible-post-installation/commit/2619291af27368a99f9126f7f13af195bff6e843))

## [2.2.2](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.2.1...v2.2.2) (2025-09-28)


### Bug Fixes

* correct syntax for GitHub token usage in Ansible playbook execution ([f56b794](https://github.com/TerrorSquad/ansible-post-installation/commit/f56b794d174de21d0aecff905330e23d1fe24f93))
* enhance conditions for reverting git user data to ensure valid values ([f45aa01](https://github.com/TerrorSquad/ansible-post-installation/commit/f45aa018f88d7bc3b172b23fe0a6737343338603))
* update GitHub token usage in Ansible playbook execution to use secrets directly ([b663dd2](https://github.com/TerrorSquad/ansible-post-installation/commit/b663dd2500909a18dabac3deaf135615c95e1dab))

## [2.2.1](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.2.0...v2.2.1) (2025-08-21)


### Bug Fixes

* always install docker ([0b3faad](https://github.com/TerrorSquad/ansible-post-installation/commit/0b3faad84f29338268a1489cb2c5db743092ae92))
* enhance GitHub API handling with token support and rate limit management ([e8cfb55](https://github.com/TerrorSquad/ansible-post-installation/commit/e8cfb55a6c54f1564f5a8fffe6013f6d9b4a921e))
* improve docker-compose architecture handling and add debug logging for installation processes ([bf4683c](https://github.com/TerrorSquad/ansible-post-installation/commit/bf4683ce8393c3f30bdd97a5978e1bbfa76b5fb9))
* update antidote function to include plugin update step and remove version pinning ([ca12d84](https://github.com/TerrorSquad/ansible-post-installation/commit/ca12d8414814b72f559e7e28aa9d389d309f8713))

## [2.2.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.1.0...v2.2.0) (2025-08-17)


### Features

* enhance cross-platform support with package lists and improved installation tasks ([284f73e](https://github.com/TerrorSquad/ansible-post-installation/commit/284f73e239d093394e1bdedd2033c64496c44c64))

## [2.1.0](https://github.com/TerrorSquad/ansible-post-installation/compare/v2.0.0...v2.1.0) (2025-08-16)


### Features

* add  app image launcher ([45681dc](https://github.com/TerrorSquad/ansible-post-installation/commit/45681dc106a9f84465b3e2ebccf5d4ad232ba2ac))
* add another zstyle config ([4f6c18d](https://github.com/TerrorSquad/ansible-post-installation/commit/4f6c18d8f9c9a9dfeed84417e8de70606c19bde7))
* add config for themes ([92c2709](https://github.com/TerrorSquad/ansible-post-installation/commit/92c27096aa423df52fc0216dd37f7edcee76b762))
* add dconf settings ([b6612c5](https://github.com/TerrorSquad/ansible-post-installation/commit/b6612c5d5e73d33814f9624d068fc6fe27533ecd))
* add DDEV installation ([e583614](https://github.com/TerrorSquad/ansible-post-installation/commit/e58361456ece24d7618d22aa7da132b0432b5365))
* add dev_tools_cli package mdcat ([ca9350f](https://github.com/TerrorSquad/ansible-post-installation/commit/ca9350f40e765dc58eb8900534f923c3ef536354))
* add docs ([dfc11ce](https://github.com/TerrorSquad/ansible-post-installation/commit/dfc11cef79f47b66b6dd0b7c8124aa00ade40052))
* add documentation ([b198858](https://github.com/TerrorSquad/ansible-post-installation/commit/b19885861b92e10d6931ab07df743e05fdf6ac47))
* add fx cli json viewer ([d43d07e](https://github.com/TerrorSquad/ansible-post-installation/commit/d43d07e70a5cbb079eb65cd7dcfef87be41346eb))
* add GitHub Pages deployment workflow and update Nuxt configuration ([d29df6e](https://github.com/TerrorSquad/ansible-post-installation/commit/d29df6e6eeb08e80d246847ccd9ea869eb73a8ed))
* add helper magento function ([38f85e9](https://github.com/TerrorSquad/ansible-post-installation/commit/38f85e96c2e1775dbcfa77f3ffcdbbc149fabe0a))
* add homebrew and install packages with it instead via github ([4ab95d6](https://github.com/TerrorSquad/ansible-post-installation/commit/4ab95d640c30d8084d7902e79d832fe948875fbb))
* add killbyname function ([c622127](https://github.com/TerrorSquad/ansible-post-installation/commit/c622127f4a81e7e97f5bcd366aa13bf9c1ab95f6))
* add kitty and helix configs ([7d9801d](https://github.com/TerrorSquad/ansible-post-installation/commit/7d9801dae62a01525fed7dda1e69de61358d0523))
* add l2tp vpn client ([718d37e](https://github.com/TerrorSquad/ansible-post-installation/commit/718d37ee17143bb236a36e90b0f3f85111902d4e))
* add macOS support ([1618652](https://github.com/TerrorSquad/ansible-post-installation/commit/161865207aac906f3f1e4c5e38df45e44bbb5e0c))
* add moderncsv ([dfd3e6c](https://github.com/TerrorSquad/ansible-post-installation/commit/dfd3e6c2770213f7413c557f48f38fde8652288e))
* add more cli tools ([517ccbd](https://github.com/TerrorSquad/ansible-post-installation/commit/517ccbd715a9bd038c4426651029c107db70f275))
* add new zsh helper functions ([3713866](https://github.com/TerrorSquad/ansible-post-installation/commit/3713866c33a11b8830a49b2b03165a54640b8069))
* add restartPlasma function to manage plasmashell ([eaa54a7](https://github.com/TerrorSquad/ansible-post-installation/commit/eaa54a70b81d1b917d48daa3924d4c0747260714))
* add reusable task to download and install remote deb packages ([339e254](https://github.com/TerrorSquad/ansible-post-installation/commit/339e254f209b49d38d532db85a94f0d85dd229bf))
* add ripgrep ([41580ef](https://github.com/TerrorSquad/ansible-post-installation/commit/41580efb7b68d7badfb54c945e270fb071834d96))
* Add Rust tools installation and completion scripts ([28a9764](https://github.com/TerrorSquad/ansible-post-installation/commit/28a976495c46fdfc757684f789cb1db64d9f0114))
* Add Rust tools installation and completion scripts ([176b90e](https://github.com/TerrorSquad/ansible-post-installation/commit/176b90e7da26a990d755d7d9d3b4abc926d27e9b))
* Add SDKMAN initialization to .zshrc ([f273380](https://github.com/TerrorSquad/ansible-post-installation/commit/f273380e1dd59a849384b6c4470a1f9029bf2bc2))
* add theme management and dconf configuration for Linux Mint ([4951cfa](https://github.com/TerrorSquad/ansible-post-installation/commit/4951cfaa8bd9a55a66313662066b816b7a2dd0a4))
* add zsh plugin zsh-nvm-auto-switch ([a37aed8](https://github.com/TerrorSquad/ansible-post-installation/commit/a37aed88eefa2b47de0d29e59bda7ecaebe54084))
* allow passing an argument to enable snap support ([5ed13fb](https://github.com/TerrorSquad/ansible-post-installation/commit/5ed13fb96c566a28ff3df07268d5e214f5456162))
* bring back fd ([4bdc248](https://github.com/TerrorSquad/ansible-post-installation/commit/4bdc24825013612a57de6d9ee175d88a2758a3e8))
* defer loading almost all zsh plugins ([f9de5ca](https://github.com/TerrorSquad/ansible-post-installation/commit/f9de5ca643c2a9669e0ac5084f25de72c94b7ebc))
* **dev_tools_cli:** add yq ([fcdb854](https://github.com/TerrorSquad/ansible-post-installation/commit/fcdb85439d1eb0a2085943ae7ee0df56f18b3950))
* Download and install DevToys in dev_tools_gui.yaml ([516aff6](https://github.com/TerrorSquad/ansible-post-installation/commit/516aff610380bfa413270282ee69338f5cada17a))
* enhance homebrew package installation with error logging ([bce232a](https://github.com/TerrorSquad/ansible-post-installation/commit/bce232a7d82248ff8eb4074d58f17d58f757ee22))
* **general:** Install redshift in general apps [skip ci] ([f911504](https://github.com/TerrorSquad/ansible-post-installation/commit/f9115041121c4d724d39c8f4e18333e85506ffa3))
* init ubuntu2304 branch ([1ff376f](https://github.com/TerrorSquad/ansible-post-installation/commit/1ff376f72f5177e96046f93a414f1a0d1d312196))
* install arc theme as well ([6643f5c](https://github.com/TerrorSquad/ansible-post-installation/commit/6643f5cf7d44a2cc0048c62a2fbe51c4a44ec762))
* install cli tools without passing a flag ([dccee53](https://github.com/TerrorSquad/ansible-post-installation/commit/dccee5381f03ebab023ec046271f403cf585e4ab))
* install code as apt ([7a5908d](https://github.com/TerrorSquad/ansible-post-installation/commit/7a5908d72475350c22085897ed4a086c3ffa4dba))
* install dbeaver-ce as apt ([6d72d63](https://github.com/TerrorSquad/ansible-post-installation/commit/6d72d6342aa554dfadc3c726e74b14080209ea35))
* install Go in dev_tools_cli ([c323ecc](https://github.com/TerrorSquad/ansible-post-installation/commit/c323ecced4fd9562e0892beb642a5d011993fb31))
* install helix cli editor ([0a5e330](https://github.com/TerrorSquad/ansible-post-installation/commit/0a5e33000761cd611245450a869eecdbd1642830))
* install input remapper, configure it for logitech mx master 3 ([4739192](https://github.com/TerrorSquad/ansible-post-installation/commit/4739192e8c090b2748bf2030eeea2fec4e24a6c0))
* install jetbrains toolbox ([5a7b93a](https://github.com/TerrorSquad/ansible-post-installation/commit/5a7b93a16587fb5fe2ea688ed264fbc84fd67d40))
* install jq ([634ad8a](https://github.com/TerrorSquad/ansible-post-installation/commit/634ad8a77e766d86efb29cab48676f9b74ed7fdb))
* Install some additional linux tools ([38451a6](https://github.com/TerrorSquad/ansible-post-installation/commit/38451a61d7cc28406465d5451d1ca654df327382))
* install vscode deb package ([277a6c8](https://github.com/TerrorSquad/ansible-post-installation/commit/277a6c82b1fc677cba8ccaa21363f1b3eeb9f01b))
* Install Zed editor in dev_tools_gui.yaml ([836ac58](https://github.com/TerrorSquad/ansible-post-installation/commit/836ac58db8b53e3ff2cb7a434648ef09c7466c7e))
* migrate certain apps to apt ([966096b](https://github.com/TerrorSquad/ansible-post-installation/commit/966096bdc016cf62aadbb26a467a5bc86d484612))
* move neovim to apt ([aa94b8d](https://github.com/TerrorSquad/ansible-post-installation/commit/aa94b8db9a20b3e995b69ae055eaa50cec49bc37))
* move only office to apt ([1e23832](https://github.com/TerrorSquad/ansible-post-installation/commit/1e238328658fe634f26697fe4776b91190c232ab))
* move to python3-apty package ([270194e](https://github.com/TerrorSquad/ansible-post-installation/commit/270194e9ebd2e2463ef1cd738cd9ca68ad74db6b))
* print post install message ([da8a97b](https://github.com/TerrorSquad/ansible-post-installation/commit/da8a97b7fd28e69448f2356ed82603431769c205))
* remove i3 ([5ebc243](https://github.com/TerrorSquad/ansible-post-installation/commit/5ebc2432b7f06b84a926cb1aa5a9fbe0cea421d7))
* rename theme changer script, add autostart funcitonality ([5eb1b67](https://github.com/TerrorSquad/ansible-post-installation/commit/5eb1b67373898b8c9e75dcd6bf096deaee4fb711))
* split cli and gui tools ([c00f9d2](https://github.com/TerrorSquad/ansible-post-installation/commit/c00f9d21cab19ba923adbdc6dc88d85c9c59915b))
* split cli and gui tools ([00c6752](https://github.com/TerrorSquad/ansible-post-installation/commit/00c6752dc261036d33b9aa36265ee24c32f3486c))
* split rust,go,java installations ([913fbef](https://github.com/TerrorSquad/ansible-post-installation/commit/913fbeff862815c909c0b2d91ee68333ea5bf934))
* Update Zsh configuration ([2c17b91](https://github.com/TerrorSquad/ansible-post-installation/commit/2c17b91b1604a1f20ff7215eca9789bace1380b9))
* use linux mint vagrant box ([31351a5](https://github.com/TerrorSquad/ansible-post-installation/commit/31351a504b44c86e5aa0b5e4ecf2e57d3577659c))


### Bug Fixes

* add back default download type for github assets - deb ([17f932b](https://github.com/TerrorSquad/ansible-post-installation/commit/17f932b138e0fcea431008bb595fee1c22a5c39d))
* add back sublime text ([8cf412c](https://github.com/TerrorSquad/ansible-post-installation/commit/8cf412c6d09057ae7b2abc32c6d268573dc1ca6d))
* add become: true next to become_user ([5177f71](https://github.com/TerrorSquad/ansible-post-installation/commit/5177f7194c0f29ad7dec3821836d74fc3b040d49))
* Add build-essential, procps, and file to basic packages ([7eae633](https://github.com/TerrorSquad/ansible-post-installation/commit/7eae6334b2b564c737494d9975f53ad56f778707))
* add docker repo only once ([7334782](https://github.com/TerrorSquad/ansible-post-installation/commit/7334782d5943afb1cc69f3546b96fb785b34a5b1))
* add Windows build workflow with WSL support ([1bf4fa5](https://github.com/TerrorSquad/ansible-post-installation/commit/1bf4fa51a2ea6fb23759f5c115feae0177ff9c4d))
* adjust formatting in README.md ([801b2d3](https://github.com/TerrorSquad/ansible-post-installation/commit/801b2d339e2d24b3ba39337c8efd47960ba6c6ea))
* albert download ([0751fcc](https://github.com/TerrorSquad/ansible-post-installation/commit/0751fcc38644a401304ccac4c5729db2af877acc))
* always download and install latest tools ([4e3a862](https://github.com/TerrorSquad/ansible-post-installation/commit/4e3a862309ecea11861df994c5a91d1c86f133a0))
* apply thems and dconf tasks only for linux mint ([ee173d2](https://github.com/TerrorSquad/ansible-post-installation/commit/ee173d20d03966afe0af004d4a903f393ba89e67))
* autostart variable ([e7b1d5a](https://github.com/TerrorSquad/ansible-post-installation/commit/e7b1d5a1ce99fba37b05d1ce364e9a6b76b2346f))
* change alias for fd-find ([c9ff345](https://github.com/TerrorSquad/ansible-post-installation/commit/c9ff34556049cb1f4f29fb84fb0e1cceef8d15f2))
* change the name of docker-compose asset ([873defc](https://github.com/TerrorSquad/ansible-post-installation/commit/873defc0b3842c2031d6bda8a2f6fb66d56080af))
* configure git user name with a variable ([348dc67](https://github.com/TerrorSquad/ansible-post-installation/commit/348dc67a1aa437b1686716d1813817335eac8cbb))
* configure nvim after installing general use CLI software ([c5390a4](https://github.com/TerrorSquad/ansible-post-installation/commit/c5390a45a08343825ac0568943b1cb88a4d939d8))
* correct extraction of ubuntu_codename from os_release_file ([02c598c](https://github.com/TerrorSquad/ansible-post-installation/commit/02c598c59e61ce38ab7fb0a2e7bc9efa186e11bb))
* create config folders with users permissions ([49f3625](https://github.com/TerrorSquad/ansible-post-installation/commit/49f3625cdb361c7149ee4bd8789f9538a71eca78))
* create terminator config directory and file ([26cef0e](https://github.com/TerrorSquad/ansible-post-installation/commit/26cef0ebe5bf6ae3abe400aa0a60b4f0ba173714))
* define use_snap variable ([9224080](https://github.com/TerrorSquad/ansible-post-installation/commit/92240804abea8d046faaf90e9302a84015e08f01))
* delete antidote directory first ([7f74fec](https://github.com/TerrorSquad/ansible-post-installation/commit/7f74fecc1a1baffdb1d5179fe7f181ba74ca99bd))
* **dependency:** update package to newer version ([0b6d14a](https://github.com/TerrorSquad/ansible-post-installation/commit/0b6d14a3792428bdffed2cb1e669046f86c82d25))
* **dev_tools:** Install sdkman as current user [skip ci] ([4d21177](https://github.com/TerrorSquad/ansible-post-installation/commit/4d211777888ef4b6313ecbeac1dd4ef9e6ca8aa4))
* do not filter github .deb files if only one URL exists ([9a5d7e3](https://github.com/TerrorSquad/ansible-post-installation/commit/9a5d7e30c92383c0975414137300752cf4f97c79))
* docker gpg key ffs ([2739d02](https://github.com/TerrorSquad/ansible-post-installation/commit/2739d021578aa2e430f1e2a613c947a68f89adf3))
* docker-compose download ([59e558f](https://github.com/TerrorSquad/ansible-post-installation/commit/59e558f94340341e9f140db9ca6eed9218e0f35d))
* don't install sublime temporarily ([7c3c54d](https://github.com/TerrorSquad/ansible-post-installation/commit/7c3c54d111e6eca4701d47e9292f44fdd9f72c5d))
* download docker-compose into /root ([86f9c81](https://github.com/TerrorSquad/ansible-post-installation/commit/86f9c81de3dff3976cf9e5efb88cc865811d9f9a))
* download latest docker-compose ([5f33d38](https://github.com/TerrorSquad/ansible-post-installation/commit/5f33d38820a652a916cb4786985414889ddcd509))
* download latest versions of delta and hyperfine as well ([87247f1](https://github.com/TerrorSquad/ansible-post-installation/commit/87247f1a513a3057ffe4452a50f966b93ce8bbda))
* download slack from its homepage URL ([a39c974](https://github.com/TerrorSquad/ansible-post-installation/commit/a39c9746e8a8ea9dbba60ae2fe5992ccfefe6629))
* download slack regardless of the version ([003833d](https://github.com/TerrorSquad/ansible-post-installation/commit/003833d3f02d2fe91e99f691ef4308d19a3c34b7))
* downloading jetbrains-toolbox ([742e290](https://github.com/TerrorSquad/ansible-post-installation/commit/742e29045a46d3b00737e70c12a9ea00fafe689a))
* dust installation ([fbdb5c9](https://github.com/TerrorSquad/ansible-post-installation/commit/fbdb5c957f2540d21563bc46eb8131caf2a54da4))
* explicitly set homebrew path ([3943461](https://github.com/TerrorSquad/ansible-post-installation/commit/39434614ef6b7e606e081b5bfdf36ee3d3d4bb18))
* filter sha files in download_github_asset.yaml ([ba40ccc](https://github.com/TerrorSquad/ansible-post-installation/commit/ba40ccc08df5c8049aab2424f2cdb25ed1652dca))
* filter sha256 explicitly ([bf56686](https://github.com/TerrorSquad/ansible-post-installation/commit/bf566868435c60a4ad6a182181b7f5412671a741))
* fix travisCI again ([a605631](https://github.com/TerrorSquad/ansible-post-installation/commit/a6056312bfd671c8337fe5fd2922ec7901777da7))
* fix TravisCI? ([ae3be10](https://github.com/TerrorSquad/ansible-post-installation/commit/ae3be10723a634971d427b82bc46564ed6ee1579))
* folder-color and skype ([30d7224](https://github.com/TerrorSquad/ansible-post-installation/commit/30d7224b37dc76ff041b1213f9376f8ff3fd8292))
* font download and installation ([d5740ec](https://github.com/TerrorSquad/ansible-post-installation/commit/d5740ec486657bec8d4c20723e5405ab8338f958))
* freaking compinit ([44f6489](https://github.com/TerrorSquad/ansible-post-installation/commit/44f648928d4604910ae88901f4bb84cdde8aa7a9))
* fzf history not working (ctrl+r) ([6e25373](https://github.com/TerrorSquad/ansible-post-installation/commit/6e2537377a21c2f7453159231ce00cc00724e890))
* github asset download, accept unknown architecture ([4851ec0](https://github.com/TerrorSquad/ansible-post-installation/commit/4851ec06c729ec7b332141db6a49020c0b771972))
* github asset download, include filename prefix all ([0d2e289](https://github.com/TerrorSquad/ansible-post-installation/commit/0d2e289fd21f59e9db6b52ed7582313299b7d736))
* glog printing redundant empty rows ([6c6838d](https://github.com/TerrorSquad/ansible-post-installation/commit/6c6838d276df15c01cc2796194ac847e4c4a3442))
* ignore [dD]arwin arch ([7853cfb](https://github.com/TerrorSquad/ansible-post-installation/commit/7853cfb57a238c468766cd0ec77ed9d7fe4ef532))
* ignore arm arch when downloading github assets ([c612cad](https://github.com/TerrorSquad/ansible-post-installation/commit/c612cad76c4ade6bdb8a9a4af3c24acd4de5d0f5))
* in exa alias, redirect stdout to /dev/null ([33d7683](https://github.com/TerrorSquad/ansible-post-installation/commit/33d7683bfd3f66f313996f5152bd3e8363f54612))
* include build.yml in workflow paths for pull requests and scheduled runs ([ae525c6](https://github.com/TerrorSquad/ansible-post-installation/commit/ae525c6f837970d1d84250847da3480275c6fd16))
* include golang.yaml, not go.yaml ([043986d](https://github.com/TerrorSquad/ansible-post-installation/commit/043986dffadc1a9c7b7dc19ee33a8e2550526898))
* install dbeaver by first downloading the .deb file ([07c3902](https://github.com/TerrorSquad/ansible-post-installation/commit/07c3902bd1acd5ab54d424868539897eda501f97))
* install git before installing homebrew ([44708d5](https://github.com/TerrorSquad/ansible-post-installation/commit/44708d5cb4c54ddd044e73fdd187ab8659a504c4))
* install jetbrains-toolbox and postman as current user (non-root) ([e5fd4b2](https://github.com/TerrorSquad/ansible-post-installation/commit/e5fd4b22547a85e38913bf90dc975df40f3a889c))
* install neovim after cli software ([2254b23](https://github.com/TerrorSquad/ansible-post-installation/commit/2254b23546e1534947bcc4f61e2e74a3bf5f4084))
* install neovim with APT, not brew ([934a032](https://github.com/TerrorSquad/ansible-post-installation/commit/934a032f045761fff1091e25d85a26a5111a0483))
* install python3-pip ([a71c4ba](https://github.com/TerrorSquad/ansible-post-installation/commit/a71c4ba017d56c8d938248b08cd325e7e53066ce))
* install xz-utils (required for installing .deb files) ([ecea28d](https://github.com/TerrorSquad/ansible-post-installation/commit/ecea28d3cc305020c985500b08d49fee383bd9ff))
* install zip ([beb57f8](https://github.com/TerrorSquad/ansible-post-installation/commit/beb57f85d71a0f2681733f796d663a3b1163fe5c))
* installing lazydocker in home dir, refactor moderncsv installation ([fc325ad](https://github.com/TerrorSquad/ansible-post-installation/commit/fc325adf78829d24343f27311ea573924cccf519))
* lower ansible verbosity in vagrant ([595cbad](https://github.com/TerrorSquad/ansible-post-installation/commit/595cbad932c65f845cac5746cac07afc6b091476))
* mailspring grep ([f4c1a0d](https://github.com/TerrorSquad/ansible-post-installation/commit/f4c1a0dbda18b6fb6c5fde3bee388ab92ddff3ac))
* moderncsv download ([3140e87](https://github.com/TerrorSquad/ansible-post-installation/commit/3140e87ebd67cbf9e92669edffa2649358b812dd))
* nodejs installation ([a8f2699](https://github.com/TerrorSquad/ansible-post-installation/commit/a8f2699471f87cbb14467561225f0c99f4cdea89))
* only office and mailspring ([dfbcec3](https://github.com/TerrorSquad/ansible-post-installation/commit/dfbcec3d3283a089bd417da0714b92a558b312a0))
* onlyoffice and modercsv now correctly install ([a7791c3](https://github.com/TerrorSquad/ansible-post-installation/commit/a7791c3b3ebe0b64f7ed4250c1b4f8b9a50e35b9))
* oops, enter dust dir once ([1f0b234](https://github.com/TerrorSquad/ansible-post-installation/commit/1f0b2345bba77d21d88311df92fa4d5b73f9f714))
* overwrite docker gpg key if exists ([f12da94](https://github.com/TerrorSquad/ansible-post-installation/commit/f12da94f199863fc9057c275bdaa5e549ffb3db1))
* pass correct URL to download ModernCSV ([c0cad2b](https://github.com/TerrorSquad/ansible-post-installation/commit/c0cad2bcb0f45b6becc40df0f3155d3122cdf2de))
* re set old git user.email and user.name after copying the .gitconfig file ([01d74e4](https://github.com/TerrorSquad/ansible-post-installation/commit/01d74e4735a09285941e0c2b7988b81e8f71187b))
* remove alacritty deb installation, switch to snap ([31f5ef0](https://github.com/TerrorSquad/ansible-post-installation/commit/31f5ef0aa9df59a88e1c594e9d590d57cee8e089))
* remove cat=bat alias ([990acf9](https://github.com/TerrorSquad/ansible-post-installation/commit/990acf94f74fb7132dfa2f14a3dee3041bf43a02))
* Remove default git_user_name and git_user_email variables ([127b6d4](https://github.com/TerrorSquad/ansible-post-installation/commit/127b6d49d8c3d644eb1a93c62cb2047da7e9e976))
* remove fd alias ([7ee79e4](https://github.com/TerrorSquad/ansible-post-installation/commit/7ee79e4fd5a0f79dd719524d5940d4c8a9fea367))
* remove httpstat installation ([3d29ce9](https://github.com/TerrorSquad/ansible-post-installation/commit/3d29ce953e7c938387b38996c223b3f958b5b583))
* remove nosnap.pref ([a692b3c](https://github.com/TerrorSquad/ansible-post-installation/commit/a692b3ca01b0d32e1fe56cd5fcabc456e3e55ab7))
* remove trailing " in two tasks ([88e3044](https://github.com/TerrorSquad/ansible-post-installation/commit/88e30440682debe1e36ea87fec1b99bebf2c792e))
* remove viber dependency installation ([b59bf91](https://github.com/TerrorSquad/ansible-post-installation/commit/b59bf91b772ebc4b150bc9f51d0e519ae12ae86e))
* remove vscode sync extension ([fed2487](https://github.com/TerrorSquad/ansible-post-installation/commit/fed248756b7f5670d52258824dd707eed7e4c785))
* remove vscode sync extension ([ccec4cb](https://github.com/TerrorSquad/ansible-post-installation/commit/ccec4cb1dadf73c7ff00c7c9828c2e0a0bec327d))
* remove zsh plugin - repo got deleted ([f6f0051](https://github.com/TerrorSquad/ansible-post-installation/commit/f6f0051bc476ee9b77b38959cab9ce153c8b8762))
* revert github actions build to ubuntu 22.04 ([f538977](https://github.com/TerrorSquad/ansible-post-installation/commit/f538977f0f61685c321476ff64e22eb985803394))
* revert github runner to ubuntu-22.04 ([d4cbfed](https://github.com/TerrorSquad/ansible-post-installation/commit/d4cbfedef96db4e44028fb9a861bdb16aa3fda66))
* reviewdog python version ([366296d](https://github.com/TerrorSquad/ansible-post-installation/commit/366296db07d45d4f5391ccc4dd3068617467dde4))
* run antidote inside zsh ([32a8be5](https://github.com/TerrorSquad/ansible-post-installation/commit/32a8be52268bb93ef95cee5dc8623f84b1f37e56))
* run theme changer in zsh ([de7d082](https://github.com/TerrorSquad/ansible-post-installation/commit/de7d0829d4a9a0cad9c70d6929aab56d2edf0991))
* sdkman is piped to bash on install ([94ceb1d](https://github.com/TerrorSquad/ansible-post-installation/commit/94ceb1d388694766a586866c5b06614fe696e66e))
* set Tixat as default torrent client regardless of LM version ([73d5843](https://github.com/TerrorSquad/ansible-post-installation/commit/73d58438bde9120bf24b87aa2741a0adca63daed))
* skip installing some failing software ([3549a55](https://github.com/TerrorSquad/ansible-post-installation/commit/3549a5580ef2d44c5cf8fc8c3c72f9cc157084e8))
* split volta download and installation ([6112dee](https://github.com/TerrorSquad/ansible-post-installation/commit/6112dee412c6f2a1fb4286367dbb43765d340eff))
* sublime text issue ([35c432a](https://github.com/TerrorSquad/ansible-post-installation/commit/35c432a394fb1b89bfd8bb0260a7b5faa63c982c))
* sublime text repo ([546432c](https://github.com/TerrorSquad/ansible-post-installation/commit/546432c0d9f8b1acbd562b574c0c176e5bbeab8a))
* tar.gz again ([147efe9](https://github.com/TerrorSquad/ansible-post-installation/commit/147efe9b5cd32a6fb032527e49c3f2263921511b))
* **temp:** ignore errors when downloading Zed ([f7c0a35](https://github.com/TerrorSquad/ansible-post-installation/commit/f7c0a35646d256c3ec95e1aad9c679b08aa7fcf1))
* terminator config variable path fixed ([a006f18](https://github.com/TerrorSquad/ansible-post-installation/commit/a006f1883cce3ef306a53c525d590d5c647620cb))
* **theme:** remove cinnazor and use adapta [skip ci] ([bb4ee8f](https://github.com/TerrorSquad/ansible-post-installation/commit/bb4ee8fd3049f13446342a54f1fe6b920507baa2))
* tixati download url ([c8ac545](https://github.com/TerrorSquad/ansible-post-installation/commit/c8ac5450dc408abcb54aef63ccc3b2ef1503a393))
* trigger compinit only on macos ([ae97766](https://github.com/TerrorSquad/ansible-post-installation/commit/ae977668481404c6514633aa69cffe7cfb5fab2b))
* Update aliases for managing directories in .zshrc ([935478c](https://github.com/TerrorSquad/ansible-post-installation/commit/935478ce4708638305ac9fd33cd89a1752b3cd22))
* update apt cache after adding a new repository ([c1df08f](https://github.com/TerrorSquad/ansible-post-installation/commit/c1df08fcc5e13f9ae1f42c1628a3164ac6b59022))
* update NodeJS, PNPM, and Yarn installation commands to use Volta without specific versions ([25f6ea7](https://github.com/TerrorSquad/ansible-post-installation/commit/25f6ea7f0aa0e7c4752c1a15a2a071f207842fcc))
* update Vagrant box to use generic/ubuntu2204 ([7e60baf](https://github.com/TerrorSquad/ansible-post-installation/commit/7e60baf1e78d993cb3d4b0b18245f755df7afa03))
* use absolute path when invoking brew ([2c30ef9](https://github.com/TerrorSquad/ansible-post-installation/commit/2c30ef97876538ff8c314e8506da217c28ce86bc))
* use add-apt-repository to add docker repo ([05b95f5](https://github.com/TerrorSquad/ansible-post-installation/commit/05b95f5f2fad71397584e42d3b828730772f553d))
* use generic ubuntu box again ([4203f38](https://github.com/TerrorSquad/ansible-post-installation/commit/4203f38a439acd8b3c168228deddcc360ba3bb6a))
* use remote_src when working with remote files ([063c02e](https://github.com/TerrorSquad/ansible-post-installation/commit/063c02e9ed46833be02cbb6b9dd00f59c561eeb8))
* use shell to copy dust ([8cbb042](https://github.com/TerrorSquad/ansible-post-installation/commit/8cbb0427defef503983350fe91185efe7b8aec06))
* use tar.gz as type for sd ([83b9981](https://github.com/TerrorSquad/ansible-post-installation/commit/83b9981c10c5e077daf1b52756d9afa807113039))
* use ubuntu codename for docker installation ([f4d92d8](https://github.com/TerrorSquad/ansible-post-installation/commit/f4d92d83cb95890a93928ce8609bf06e4752f71f))
* zsh plugins - compdef not found [skip ci] ([444273a](https://github.com/TerrorSquad/ansible-post-installation/commit/444273ad2af7108bb5024b328468762dc07bb76d))
* **zshrc:** ignore commands prefixed with space ([53e78a5](https://github.com/TerrorSquad/ansible-post-installation/commit/53e78a50028255d10f79d023f8b358855811a492))
* **zsh:** run antidote update instead of update-antidote ([22c0902](https://github.com/TerrorSquad/ansible-post-installation/commit/22c0902fb409e53835217b232543ebd4ea0473e8))
