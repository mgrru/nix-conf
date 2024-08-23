{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      log = {
        enabled = false;
      };
    };
    # flavors = {
    #   bar = pkgs.bar;
    # };
  };
}
