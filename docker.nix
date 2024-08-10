{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      ipv6 = true;
      log-driver = "json-file";
      log-opts = { max-size = "100M"; };
      registry-mirrors = [ "https://docker.m.daocloud.io" ];
    };
    storageDriver = "btrfs";
  };

  virtualisation.oci-containers = {
    backend = "docker";
  };
}
