{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs = {


    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvchad;
        }
      ];
    };

    firefox = {
      enable = true;

      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://duckduckgo.com";
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "browser.urlbar.placeholderName.private" = "DuckDuckGo";
          "browser.toolbars.bookmarks.visibility" = "always";
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSearch" = false;
          "general.autoScroll" = true;
        };
        bookmarks = [
          {
            name = "Personal";
            toolbar = true;
            bookmarks = [
              {
                name = "TU Moodle";
                url = "https://sso.itmc.tu-dortmund.de/openam/XUI/?goto=https%3A%2F%2Fmoodle.tu-dortmund.de%2Flogin#login/";
              }
              {
                name = "TU Webmail";
                url = "https://webmail.tu-dortmund.de/roundcubemail/";
              }
              {
                name = "LSF";
                url = "https://www.lsf.tu-dortmund.de/qisserver/rds;jsessionid=2890323298CD74A8B42AE78E0A5DAC16.lsf6?state=user&type=0&category=menu.browse&breadCrumbSource=&startpage=portal.vm";
              }
              {
                name = "TU Boss";
                url = "https://www.boss.tu-dortmund.de/qisserver/rds?state=user&type=0";
              }
              {
                name = "Overleaf";
                url = "https://overleaf.com/project";
              }
              {
                name = "MyNixOS";
                url = "https://mynixos.com/";
              }
            ];
          }
        ];
        search.default = "DuckDuckGo";
        search.force = true;
      };
    };

    git = {
      enable = true;
      userName = "Maik Steiger";
      userEmail = "m.steiger@csurielektronics.com";
    };

  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ich";
  home.homeDirectory = "/home/ich";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    #openjdk8
    #openjdk17
    openjdk11
    discord
    maestral
    prismlauncher
    minecraft
    steam
    cura
    obs-studio
    putty
    zoom-us
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    "discord/settings.json".text = ''
      {
        "SKIP_HOST_UPDATE": true
      }
    '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ich/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}