{ ... }:

{
  networking = {
    hostName = "rnix"; # Define your hostname.
    networkmanager.enable = true;
    # firewall = {
    #   allowedTCPPorts = [ 22 443 6000 ];
    #   allowedUDPPorts = [ 22 443 6000 ];
    # };
  };
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.firewall.enable = false;
}
