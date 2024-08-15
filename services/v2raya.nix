{ ... }:

{
  services.v2raya.enable = true;
  services.v2ray = {
    enable = true;
    config = {
      inbounds = [
        {
          listen = "127.0.0.1";
          port = 1080;
          protocol = "http";
        }
      ];
      outbounds = [ { protocol = "freedom"; } ];
    };
  };
  services.prometheus.exporters.v2ray.openFirewall = true;
}
