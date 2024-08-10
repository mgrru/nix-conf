{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      ipv6 = true;
      log-driver = "json-file";
      log-opts = "{\n        " max-size " : " 100 M "\n      }";
      registry-mirrors = [ "https://docker.m.daocloud.io" ];
    };
    storageDriver = "btrfs";
  };
}
