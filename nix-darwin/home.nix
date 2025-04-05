{ config, pkgs, ... }:

{
  home.username = "sascha";
  home.homeDirectory = "/Users/sascha";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  imports = [ ./starship.nix ];

  home.packages = with pkgs; [
    bat
    chezmoi
    civo
    csview
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
    kns
    krew
    kubectl
    kustomize
    lazydocker
    lazygit
    pandoc
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
    zsh-syntax-highlighting
  ];

  home.file = {
    ".config/nvim".source = ../nvim;
    ".config/zellij".source = ../zellij;
    ".config/karabiner".source = ../karabiner;
    ".config/delta".source = ../delta;
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

  programs.bat = {
    enable = true;
    config.theme = "catppuccin-macchiato";
    themes = {
      catppuccin-macchiato = {
        src = pkgs.fetchFromGitHub {
          "owner" = "catppuccin";
          "repo" = "bat";
          "rev" = "d2bbee4f7e7d5bac63c054e4d8eca57954b31471";
          "sha256" = "x1yqPCWuoBSx/cI94eA+AWwhiSA42cLNUOFJl7qjhmw=";
        };
        file = "themes/Catppuccin Macchiato.tmTheme";
      };
    };
  };

  programs.git = {
    enable = true;
    delta.enable = true;
    lfs.enable = true;
    userName = "sselzer";
    userEmail = "sascha.selzer@gmail.com";
    includes = [ { path = ../delta/themes/catppuccin.gitconfig; } ];
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      delta.features = "catpuccin-macchiato";
      delta.navigate = true;
      pull.rebase = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
      gui.theme = {
        activeBorderColor = [ "#f5a97f" "bold" ];
        inactiveBorderColor = [ "#a5adcb" ];
        optionsTextColor = [ "#8aadf4" ];
        selectedLineBgColor = [ "#363a4f" ];
        cherryPickedCommitBgColor = [ "#494d64" ];
        cherryPickedCommitFgColor = [ "#f5a97f" ];
        unstagedChangesColor = [ "#ed8796" ];
        defaultFgColor = [ "#cad3f5" ];
        searchingActiveBorderColor = [ "#eed49f" ];
      };
      gui.authorColor = {
        "*" = "#b7bdf8";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
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
