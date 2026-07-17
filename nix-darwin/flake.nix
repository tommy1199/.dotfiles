{
  description = "DevMac Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, mac-app-util }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        async-profiler
        btop
        doggo
        git
        go
        libdvdcss
        mkalias
        neovim
        nodejs_24
        viddy
        watch
        zsh
        zulu25
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      homebrew = {
        enable = true;
        brews = [
          "charmbracelet/tap/crush"
          "mas"
          "metalbear-co/mirrord/mirrord"
          "vexctl"
        ];
        casks = [
          "1password"
          "1password-cli"
          "alfred"
          "claude-code@latest"
          "dropbox"
          "ghostty"
          "handbrake-app"
          "jetbrains-toolbox"
          "jitsi-meet"
          "karabiner-elements"
          "marta"
          "microsoft-auto-update"
          "microsoft-teams"
          "notion"
          "orbstack"
          "scummvm-app"
          "slack"
          "snes9x"
          "spotify"
          "steam"
          "surfshark"
          "the-unarchiver"
          "visual-studio-code"
          "vivaldi"
          "vlc"
          "zoom"
        ];
        masApps = {
        };
        taps = [
          "nikitabobko/tap"
          "metalbear-co/mirrord"
        ];
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        onActivation.extraEnv = {
          HOMEBREW_NO_ANALYTICS = "1";
          HOMEBREW_NO_ENV_HINTS = "1";
        };
      };

      services.aerospace.enable = true;
      services.aerospace.settings = pkgs.lib.importTOML ../aerospace/aerospace.toml;


      system.defaults = {
        dock.autohide = true;    
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.AppleShowAllExtensions = true;
        NSGlobalDomain.KeyRepeat = 2;
      };

      security.pam.services.sudo_local.touchIdAuth = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.direnv.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.sascha.home = "/Users/sascha";
      system.primaryUser = "sascha";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#devmac
    darwinConfigurations."devmac" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        mac-app-util.darwinModules.default
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
          home-manager.sharedModules = [
            mac-app-util.homeManagerModules.default
          ];
          home-manager.users.sascha = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."devmac".pkgs;
  };
}
