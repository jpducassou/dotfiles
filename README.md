# DOTFILES

## Introduction

This repo hosts my custom config files for linux.

## Requirements

* git
* bash

## Setup

``` bash
git clone https://github.com/jpducassou/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Debian packages

`packages/*.lst` files list Debian packages by category (basic tools,
desktop, development, etc.). Install the packages from a list as root:

``` bash
sudo packages/install.sh packages/01-basic.lst
```

## Development toolchains

Each script below installs one toolchain manager and appends its shell
initialization to `~/.bash_post` (see [Machine-specific shell
config](#machine-specific-shell-config)):

* `./install_java.sh` — installs SDKMAN and jenv, then Java 17, 21, and 25
  (Amazon Corretto) via SDKMAN, with jenv managing the active version
  (default: 21)
* `./install_node.sh` — installs nvm, then Node.js 22 and 24 via nvm
  (default: 24), plus pnpm and `markdownlint-cli`
* `./install_python.sh` — configures pyenv for interactive shells (pyenv
  itself must already be installed)

## Machine-specific shell config

`~/.bash_pre` and `~/.bash_post` are untracked files sourced by
`root/.bashrc` at the very start and very end, respectively, when they
exist. Use them for configuration that should never be committed —
proxy settings, work aliases, local overrides. The toolchain installers
above append their initialization blocks to `~/.bash_post` automatically
and skip re-appending a block that is already present.

## Updating

`install.sh` installs itself as the `post-checkout` and `post-merge` git
hooks, so a plain `git pull` automatically refreshes the symlinks. To
update the vim-plugin submodules, run:

``` bash
./upgrade.sh
```

## Further reading

There is a lot of info out there about dotfiles, just check:

* [dotfiles.github.io](http://dotfiles.github.io/)
* [Using Git and Github to Manage Your Dotfiles](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/)

## Author

Jean Pierre Ducassou

## License

See LICENSE file

