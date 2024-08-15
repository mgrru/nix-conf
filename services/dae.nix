{ ... }:

{
  services.dae = {
    enable = true;
    configFile = ./config.dae;
    openFirewall.enable = true;
  };
}
