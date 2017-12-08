{ config, pkgs, ... }:

with pkgs;

let

  helloImage = callPackage ./hello {};

in

{
  systemd.services.docker-pull-helloImage = {
    wantedBy = [ "multi-user.target" ];
    requires = [ "docker.service" ];
    after = [ "docker.service" ];
    serviceConfig.ExecStart = "${docker}/bin/docker load -i ${helloImage}";
    serviceConfig.PermissionsStartOnly = true;
    serviceConfig.User = "root";
    serviceConfig.Type = "oneshot";
    serviceConfig.RemainAfterExit = true;
  };
}