{ pkgs, ... }:

let
  java_version = 21;
in
{
  nixpkgs.overlays.default = (final: prev: rec {
    jdk = prev."jdk${toString java_version}";
    maven = prev.maven.override { jre = jdk; };
  });

  home.packages = with pkgs; [ maven ];

  programs.java = {
    enable = true;
  };

  home.file.".m2/settings.xml".source = ./settings.xml;

}
