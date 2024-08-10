{ ... }:

{
  networking.hostName = "rnix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Easiest to use and most distros use this by default.
  networking.networkmanager.enable = true;

  services.dae = {
    enable = true;
    configFile = ./config.dae;
  };
}
