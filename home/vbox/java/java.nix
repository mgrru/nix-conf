{ pkgs, ... }:

{

  home.packages = with pkgs; [ maven ];

  programs.java = {
    enable = true;
  };

  home.file.".m2/settings.xml".source = ./settings.xml;

}
