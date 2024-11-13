{ config, pkgs, ... }:

{
  home.username = "sascha";
  home.homeDirectory = "/Users/sascha";
  home.stateVersion = "23.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = ../zsh/.zshrc;
    ".config/starship.toml".source = ../starship/starship.toml;
    ".config/nvim".source = ../nvim;
    ".config/zellij".source = ../zellij;
    ".config/delta".source = ../delta;
    ".config/lazygit".source = ../lazygit;
    ".config/bat".source = ../bat;
    ".config/kitty".source = ../kitty;
    "fzf-git.sh".source = ../fzf-git.sh;
    ".tmux.conf".source = ../tmux/.tmux.conf;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
}
