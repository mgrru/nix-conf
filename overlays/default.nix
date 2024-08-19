{ ... }:
let
  java_version = 17; # Change this value to update the whole stack
in
{
  nixpkgs.overlays = [
    (final: prev: rec {
      jdk = prev."jdk${toString java_version}";
      maven = prev.maven.override { jre = jdk; };
    })
  ];
}
