{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
      commonModules = [
        ./configuration.nix
        ./locale.nix
        ./shell.nix
        ./dev.nix
        ./myuser.nix

        #./packages/nvchad.nix
      ];
    in {
      nixosConfigurations = {
        ich = lib.nixosSystem {
          inherit system;
          modules = commonModules ++ [
            ({ pkgs, ... }: { networking.hostName = "ich-nixos"; }) 
            ./hardware.nix 
            ./audio.nix
            ./kde-desktop.nix
            ./printer.nix
          ];
        };
      };
      homeConfigurations.ich = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];
      };
    };
}
