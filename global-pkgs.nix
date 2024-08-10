{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openssh
    openssl
    wget
    curl
  ];
}
