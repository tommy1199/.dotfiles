#!/bin/bash

## Install dotfiles
sh <(curl -L https://nixos.org/nix/install)
nix-shell -p git --run 'git clone https://github.com/tommy1199/.dotfiles' ~/.dotfiles
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/nix-darwin#devmac

## Link bat themes and configuration
bat cache --build
