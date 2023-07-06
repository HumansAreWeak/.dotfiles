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

Generate yourself a hardware configuration of your system and safe it into the current folder

```
nixos-generate-config --dir .
```

## Reproduce NixOS

To reproduce my OS, simply type

```
sudo nixos-rebuild switch --flake .#ich
```

## Reproduce Home-Manager

To reproduce my development environment, use the following command

```
# Build
nix build .#homeConfigurations.ich.activationPackage

# Activate
./result/activate
```