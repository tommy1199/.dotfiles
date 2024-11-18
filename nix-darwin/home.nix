{ config, pkgs, ... }:

{
  home.username = "sascha";
  home.homeDirectory = "/Users/sascha";
  home.stateVersion = "23.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = with pkgs; [
    bat
    delta
    devbox
    direnv
    discord
    dive
    eza
    fzf
    grype
    jq
    just
    k9s
    krew
    kubectl
    kustomize
    lazydocker
    lazygit
    ripgrep
    starship
    syft
    tealdeer
    thefuck
    yazi
    yq-go
    zoom-us
    zoxide
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    #".zshrc".source = ../zsh/.zshrc;
    ".config/starship.toml".source = ../starship/starship.toml;
    ".config/nvim".source = ../nvim;
    ".config/zellij".source = ../zellij;
    ".config/delta".source = ../delta;
    ".config/lazygit".source = ../lazygit;
    ".config/bat".source = ../bat;
    ".config/kitty".source = ../kitty;
    ".tmux.conf".source = ../tmux/.tmux.conf;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
  };

  programs.zsh.shellAliases = {
    cat = "bat -p";
    cdr = "cd $(git rev-parse --show-toplevel)";
    clip = "silicon --pad-horiz 0 --pad-vert 0 --background '#ffffff' --theme OneHalfDark --to-clipboard";
    gcms = "gaa && gcmsg 'Update' && gp";
    grpo = "git remote prune origin";
    ll = "ls -l --no-user --no-time";
    lla = "ll -a";
    tree = "ls --tree";
    treel = "tree --long";
    lg = "lazygit";
    vi = "nvim";
    vim = "nvim";
    cd = "z";
    flakedit = "nvim ~/.dotfiles/nix-darwin/flake.nix";
  };

  programs.zsh.sessionVariables = {
    JUST_SUPPRESS_DOTENV_LOAD_WARNING = "1";
    LANG = "en_US.UTF-8";
    EDITOR = "nvim";
    VISUAL = "nvim";
    BAT_THEME = "Catppuccin Macchiato";
    HOMEBREW_NO_ENV_HINTS = "false";
  };

  programs.zsh.plugins = [
    {
      name = "zsh-kubectl";
      file = "plugins/kubectl/kubectl.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "ohmyzsh";
        repo = "ohmyzsh";
        rev = "ca5471fe496f00007727fd26db762d19519c2e8f";
        sha256 = "rI673tQ3W4U9N5i8LZx9dpKzft7+Y0UZ7iTSJwnoSSE=";
      };
    }
    {
      name = "zsh-git";
      file = "plugins/git/git.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "ohmyzsh";
        repo = "ohmyzsh";
        rev = "ca5471fe496f00007727fd26db762d19519c2e8f";
        sha256 = "rI673tQ3W4U9N5i8LZx9dpKzft7+Y0UZ7iTSJwnoSSE=";
      };
    }
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    colors = "always";
    icons = "always";
  };
}
