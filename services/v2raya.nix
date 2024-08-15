{ ... }:

{
  services.v2raya.enable = true;
  services.v2ray.enable = true;
  services.prometheus.exporters.v2ray.openFirewall = true;
}
