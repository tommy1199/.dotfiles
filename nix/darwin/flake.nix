{
  description = "DevMac Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        bat
        devbox
        direnv
        dive
        eza
        fastfetch
        fnm
        fzf
        go
        grype
        jq
        kustomize
        lazygit
        mkalias
        neovim
        ngrok
        pyenv
        ripgrep
        starship
        syft
        tealdeer
        thefuck
        yazi
        yq-go
        zoxide
      ];

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
        ];
        casks = [
          "1password"
          "iina"
          "1password-cli"
          "alfred"
          "android-file-transfer"
          "brave-browser"
          "discord"
          "drawio"
          "dropbox"
          "jetbrains-toolbox"
          "jitsi-meet"
          "karabiner-elements"
          "kitty"
          "logitech-camera-settings"
          "logitech-presentation"
          "marta"
          "microsoft-auto-update"
          "microsoft-teams"
          "nikitabobko/tap/aerospace"
          "notion"
          "orbstack"
          "proxyman"
          "scummvm"
          "slack"
          "steam"
          "the-unarchiver"
          "visual-studio-code"
          "zoom"
        ];
        masApps = {
          "Xcode" = 497799835;
          "AusweisApp Bund" = 948660805;
        };
        taps = [
          "nikitabobko/tap"
        ];
        onActivation.cleanup = "zap";
      };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
      '';

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#devmac
    darwinConfigurations."devmac" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "sascha";
            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."devmac".pkgs;
  };
}