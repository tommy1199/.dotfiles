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
    ".zshrc".source = ~/.dotfiles/zsh/.zshrc;
    ".config/starship.toml".source = ~/.dotfiles/starship/starship.toml;
    ".config/nvim".source = ~/.dotfiles/nvim;
    ".config/zellij".source = ~/.dotfiles/zellij;
    ".config/delta".source = ~/.dotfiles/delta;
    ".config/lazygit".source = ~/.dotfiles/lazygit;
    ".config/bat".source = ~/.dotfiles/bat;
    ".config/kitty".source = ~/.dotfiles/kitty;
    "fzf-git.sh".source = ~/.dotfiles/fzf-git.sh;
    ".tmux.conf".source = ~/.dotfiles/tmux/.tmux.conf;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
}
