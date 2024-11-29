{
  description = "DevMac Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        btop
        git
        mkalias
        neovim
        watch
        zsh
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
          "metalbear-co/mirrord/mirrord"
        ];
        casks = [
          "1password"
          "1password-cli"
          "alfred"
          "brave-browser"
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
          "scummvm"
          "slack"
          "steam"
          "the-unarchiver"
          "visual-studio-code"
        ];
        masApps = {
          "Xcode" = 497799835;
          "AusweisApp Bund" = 948660805;
        };
        taps = [
          "nikitabobko/tap"
          "metalbear-co/mirrord"
        ];
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      services.aerospace.enable = true;
      services.aerospace.settings = {
          accordion-padding = 30;
          after-login-command = [ ];
          after-startup-command = [ ];
          default-root-container-layout = "tiles";
          default-root-container-orientation = "auto";
          enable-normalization-flatten-containers = true;
          enable-normalization-opposite-orientation-for-nested-containers = true;
          gaps = {
            inner = {
              horizontal = 5;
              vertical = 5;
            };
            outer = {
              bottom = 5;
              left = 5;
              right = 5;
              top = 5;
            };
          };
          key-mapping = { preset = "qwerty"; };
          mode = {
            main = {
              binding = {
                ctrl-1 = "workspace 1";
                ctrl-2 = "workspace 2";
                ctrl-3 = "workspace 3";
                ctrl-4 = "workspace 4";
                ctrl-b = "workspace B";
                ctrl-comma = "layout accordion horizontal vertical";
                ctrl-e = "workspace E";
                ctrl-h = "focus left";
                ctrl-j = "focus down";
                ctrl-k = "focus up";
                ctrl-l = "focus right";
                ctrl-m = "fullscreen";
                ctrl-shift-1 = "move-node-to-workspace 1";
                ctrl-shift-2 = "move-node-to-workspace 2";
                ctrl-shift-3 = "move-node-to-workspace 3";
                ctrl-shift-4 = "move-node-to-workspace 4";
                ctrl-shift-b = "move-node-to-workspace B";
                ctrl-shift-comma = "layout tiles horizontal vertical";
                ctrl-shift-e = "move-node-to-workspace E";
                ctrl-shift-equal = "resize smart +50";
                ctrl-shift-h = "move left";
                ctrl-shift-j = "move down";
                ctrl-shift-k = "move up";
                ctrl-shift-l = "move right";
                ctrl-shift-minus = "resize smart -50";
                ctrl-shift-period = "mode service";
                ctrl-shift-t = "move-node-to-workspace T";
                ctrl-shift-tab = "move-workspace-to-monitor --wrap-around next";
                ctrl-t = "workspace T";
                ctrl-tab = "workspace-back-and-forth";
              };
            };
            service = {
              binding = {
                ctrl-shift-h = [
                  "join-with left"
                  "mode main"
                ];
                ctrl-shift-j = [
                  "join-with down"
                  "mode main"
                ];
                ctrl-shift-k = [
                  "join-with up"
                  "mode main"
                ];
                ctrl-shift-l = [
                  "join-with right"
                  "mode main"
                ];
                backspace = [
                  "close-all-windows-but-current"
                  "mode main"
                ];
                esc = [
                  "reload-config"
                  "mode main"
                ];
                f = [
                  "layout floating tiling"
                  "mode main"
                ];
                r = [
                  "flatten-workspace-tree"
                  "mode main"
                ];
              };
            };
          };
          on-focus-changed = [ "move-mouse window-lazy-center" ];
          on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      };
      system.activationScripts.extraActivation.text = ''
        softwareupdate --install-rosetta --agree-to-license
      '';
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
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
      '';

      system.defaults = {
        dock.autohide = true;    
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.AppleShowAllExtensions = true;
        NSGlobalDomain.KeyRepeat = 2;
      };

      security.pam.enableSudoTouchIdAuth = true;

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.direnv.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.sascha.home = "/Users/sascha";
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
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sascha = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."devmac".pkgs;
  };
}
