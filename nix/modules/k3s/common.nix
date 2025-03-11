{ config, ... }:
let
  hostname = config.networking.hostName;
  hosts = import ../../hosts.nix;
in
{
  services.k3s = {
    enable = true;
    tokenFile = config.sops.secrets.k3s-token.path;
    extraFlags = [
      "--node-external-ip=${hosts.${hostname}.address}"
    ];
  };
  sops.secrets.k3s-token = {
    owner = "root";
    mode = "0400";
  };
}
