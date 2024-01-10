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

## Install zsh-plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## Install powerlevel10k theme
[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm ~/.p10k.zsh
ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh

$(brew --prefix)/opt/fzf/install

## Install sdkman
curl -s "https://get.sdkman.io" | bash

## Install krew
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

## Install crossplane cli
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh
sudo mv kubectl-crossplane /opt/homebrew/bin

## Install color theme for iterm2
curl https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors -o ~/Downloads/material-design-colors.itermcolors

## Link Brewfile and zshrc to home directory
rm ~/Brewfile
ln -s ~/.dotfiles/Brewfile ~/Brewfile
rm ~/.zshrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
