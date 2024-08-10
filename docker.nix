{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      ipv6 = true;
      registry-mirrors = [ "https://docker.m.daocloud.io" ];
    };
    storageDriver = "btrfs";
  };

  virtualisation.oci-containers = {
    backend = "docker";
  };
}
