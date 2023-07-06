{ config, lib, pkgs, ... }: {
  config = {
    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    users.users.ich.extraGroups = [ "audio" ];
  };
}
