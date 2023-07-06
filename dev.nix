{ config, pkgs, lib, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      # Microcontroller stuff
      avrdude

      # HaPra
      ghdl
      gtkwave

      # Nix
      nixd
      nil

      # Tools
      openjdk11
      python3
      cmake
      man-pages
      nodejs
      gcc

      wireguard-tools
    ];

    # Add user to necessary groups
    users.users.ich.extraGroups = [ "docker" ];

    # Docker
    virtualisation.docker.enable = true;

    environment.shellAliases = {
      ll = "ls -la --color=auto";
    };
  };
}
