# My NixOS Flake

## Setup

Clone the repository

```
git clone https://github.com/HumansAreWeak/.dotfiles haw-flake
```

Then open the directory

```
cd haw-flake
```

Change the ```hardware.nix``` according to your system's hardware. Additionally edit ```kde-desktop.nix``` for GPU settings, since I'm using Nvidia with Prime on.

## Reproduce NixOS

To reproduce my OS, simply type

```
sudo nixos-rebuild switch --flake .#ich
```

## Reproduce Home-Manager

To reproduce my development environment, use the following command's

```
# Build
nix build .#homeConfigurations.ich.activationPackage

# Activate
./result/activate
```
