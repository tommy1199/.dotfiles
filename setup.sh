#!/bin/bash

## Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' > ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

## Install rosetta
softwareupdate --install-rosetta --agree-to-license

## Install brew packages
brew install mas
brew bundle

## Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/cd-gitroot ] && git clone https://github.com/mollifier/cd-gitroot.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/cd-gitroot

## Install powerlevel10k theme
[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
p10k configure

$(brew --prefix)/opt/fzf/install

## Install sdkman
curl -s "https://get.sdkman.io" | bash

## Install color theme for iterm2
curl https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors -o ~/Downloads/material-design-colors.itermcolors

## Link Brewfile and zshrc to home directory
rm ~/Brewfile
ln -s ~/.dotfiles/Brewfile ~/Brewfile
rm ~/.zshrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc