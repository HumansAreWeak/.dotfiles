# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #  "nvidia"
  #];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # nixpkgs.config.allowUnfreePredicate = pkg:
  # 	builtins.elem(lib.getName pkg) [
	# 	"vscode"
	# 	"vscode-with-extensions"
	# 	"nvidia-x11"
	# 	"nvidia-settings"
	# 	"discord"
	# ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.enableContainers = false;
  boot.supportedFilesystems = [ "ntfs" ];
  #boot.extraModulePackages = [ pkgs.linuxPackages.nvidia_x11 ];

  networking.hostName = "ich-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #  useXkbConfig = true; # use xkbOptions in tty.
  #};

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.xmonad.enable = true;
    displayManager.defaultSession = "plasma";
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "ich";
    videoDrivers = [ "nvidia" ];

    # Configure keymap in X11
    layout = "de";
    xkbOptions = "nodeadkeys";
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      nvidiaPersistenced = true;

      prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ich = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Useful programs
    #neovim
    #vimPlugins.nvchad
    #vimPlugins.nvchad-extensions
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        dbaeumer.vscode-eslint
        # amodio.tsl-problem-matcher
        jnoortheen.nix-ide
        esbenp.prettier-vscode
      ];
    })
    wireguard-tools
    wget
    filezilla
    git
    firefox
    htop
    libreoffice-qt
    cmake
    nodejs
    gcc

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

    # Wine stuff
    winetricks
    wineWowPackages.stable

    # JetBrains + Google stuff
    #jetbrains-toolbox
    jetbrains.webstorm
    jetbrains.idea-ultimate
    jetbrains.clion
    android-studio

    # Microcontroller stuff
    avrdude

    # HaPra
    ghdl
    gtkwave
    
    # KDE Themes
    artim-dark
  ];

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  environment.shellAliases = {
    ll = "ls -la --color=auto";
  };

  security.sudo.extraRules = [
    {
      users = [ "ich" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "gtk2";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

