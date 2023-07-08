{ config, pkgs, lib, ... }: {

  # Allow Unfree packages
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    # Desktop Manager
    desktopManager.plasma5.enable = true;

    # Window Manager
    windowManager.xmonad.enable = true;

    # Display Manager
    displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasma";
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "ich";

    # Configure keymap in X11
    layout = "de";
    xkbOptions = "nodeadkeys";
  };

  # QT Kde
  qt = {
    enable = true;
    platformTheme = "kde";
    style = "gtk2";
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  # Desktop related packages
  environment.systemPackages = with pkgs; [
    # KDE related
    libsForQt5.kate
    libsForQt5.kmail
    libsForQt5.kontact
    libsForQt5.accounts-qt
    libsForQt5.kalendar
    libsForQt5.kalk
    libsForQt5.kalzium
    libsForQt5.kdeplasma-addons
    libsForQt5.plasma-workspace
    libsForQt5.plasma-workspace-wallpapers

    # KDE Themes
    artim-dark

    # Dev related
    jetbrains.webstorm
    jetbrains.idea-ultimate
    jetbrains.clion
    android-studio

    # Office
    firefox
    vlc
    libreoffice-qt
    filezilla

    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        dbaeumer.vscode-eslint
        # amodio.tsl-problem-matcher
        jnoortheen.nix-ide
        esbenp.prettier-vscode
      ];
    })

    # Games
    winetricks
    wineWowPackages.stable
  ];

  networking.networkmanager = {
    enable = true;  # Easiest to use and most distros use this by default.
    unmanaged = [
      "vboxnet" "docker0" "docker1" "docker2"
    ];
  };

  networking.firewall = {
    checkReversePath = false;
    
    # WireGuard Port
    allowedUDPPorts = [ 25621 ];
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;

      prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
    };
  };

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
