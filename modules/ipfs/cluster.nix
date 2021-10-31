{ config, lib, pkgs, ... }:

{
  imports = [ ./default.nix ];
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
  };
}
