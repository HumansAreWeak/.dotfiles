{ config, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      htop
      wget
      git
      tree
      zip
      unzip
      whois
      gnupg
    ];

    programs.less.enable = true;
    programs.zsh.enable = true;

    # Use nix-index' better command-not-found
    programs.command-not-found.enable = false;
    programs.nix-index = {
      enable = true;
      enableFishIntegration = false; # Don't use it
    };
    environment.extraSetup =
      # 'Install' neovim-unwrapped for help in debugging neovim/vim issues
    ''
      ln -s ${pkgs.neovim-unwrapped}/bin/nvim $out/bin/nvim-unwrapped
    '';

    nixpkgs.config.allowUnfree = true;
  };
}
