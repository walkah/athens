{ config, lib, pkgs, ... }:

{
  imports = [
    ./default.nix
    ../../services/ipfs-cluster.nix
  ];

  services = {
    ipfs = {
      enable = true;
      extraConfig = {
        Swarm = {
          AddrFilters = null;
          ConnMgr = {
            Type = "basic";
            LowWater = 25;
            HighWater = 50;
            GracePeriod = "1m0s";
          };
        };
      };
    };

    ipfs-cluster = {
      enable = true;
      consensus = "crdt";
      secretFile = config.sops.secrets.ipfs-cluster-secret.path;
    };
  };

  sops.secrets.ipfs-cluster-secret = {
    owner = "ipfs";
  };
}
