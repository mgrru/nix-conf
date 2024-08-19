{ pkgs, ... }:

{

  home.packages = with pkgs; [
    maven
    jdk17
  ];

  programs.java = {
    enable = true;
    package = with pkgs; [ jdk17 ];
  };
  # programs.sbt.enable = true;

  home.file.".m2/settings.xml".source = ./settings.xml;

}
