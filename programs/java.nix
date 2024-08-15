{ pkgs, ... }:

{
  users.users.ru.packages = with pkgs; [
    maven
    jdk21
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
