{ config, pkgs, lib, ... }: {
  config = {
    users.users.ich = {
      isNormalUser = true;
      shell = pkgs.zsh;
      createHome = true;
      extraGroups = [ "wheels" "networkmanager" ];
    };

    nix.settings.trusted-users = [
      "ich"
    ];


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
  };
}