{ config, lib, pkgs, ... }: {
  config = {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}