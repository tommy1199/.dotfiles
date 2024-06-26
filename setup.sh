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
curl https://raw.githubusercontent.com/herrbischoff/iterm2-gruvbox/master/gruvbox.itermcolors -o ~/Downloads/gruvbox.itermcolors

## Link Brewfile and zshrc to home directory
[ -f ~/Brewfile ] && rm /Brewfile
ln -s ~/.dotfiles/Brewfile ~/Brewfile
[ -f ~/.zshrc ] && rm ~/.zshrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
[ -f ~/.config/starship.toml ] && rm ~/.config/starship.toml
ln -s ~/.dotfiles/starship.toml ~/.config/starship.toml

## Link neovim configuration
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/fzf-git.sh ~/fzf-git.sh

## Link tmux configuration
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

## Link bat themes and configuration
ln -s ~/.dotfiles/bat ~/.config/bat
bat cache --build

## Link alacritty configuration
ln -s ~/.dotfiles/alacritty ~/.config/alacritty

## Link lazygit configuration
ln -s ~/.dotfiles/lazygit ~/.config/lazygit

## Link gitconfig and delta configuration
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/delta ~/.config/delta

## Link zellij configuration
ln -s ~/.dotfiles/zellij ~/.config/zellij
