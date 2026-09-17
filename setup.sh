#!/bin/bash

## Install dotfiles
echo "Install rosetta"
softwareupdate --install-rosetta --agree-to-license
echo "Install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Install nix"
sh <(curl -L https://nixos.org/nix/install)
echo "Clone dotfiles"
nix-shell -p git --run 'git clone https://github.com/tommy1199/.dotfiles' ~/.dotfiles
echo "Run nix switch"
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/nix-darwin#devmac
tuckr add \*
