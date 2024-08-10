{ config, lib, pkgs, ... }:

{
  networking.hostName = "rnix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.dae = {
    enable = true;
    configFile = ./config.dae;
  };
}