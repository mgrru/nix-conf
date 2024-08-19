{ pkgs, ... }:

{

  home.packages = with pkgs; [ maven ];

  programs.java = {
    enable = true;
    package = with pkgs;[ jdk21 ];
  };
  programs.sbt.enable = true;

  home.file.".m2/settings.xml".source = ./settings.xml;

}
