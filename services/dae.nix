{ ... }:

{
  services.dae = {
    enable = false;
    configFile = ./config.dae;
    openFirewall = {
      enable = true;
      port = 10880;
    };
  };
}
