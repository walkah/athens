{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ipfs-migrator ];

  services = {
    kubo = {
      enable = true;
      apiAddress = "/ip4/0.0.0.0/tcp/5001";
      gatewayAddress = "/ip4/0.0.0.0/tcp/8080";
      swarmAddress = [
        "/ip4/0.0.0.0/tcp/4001"
        "/ip6/::/tcp/4001"
        "/ip4/0.0.0.0/udp/4001/quic"
        "/ip6/::/udp/4001/quic"
      ];
      extraConfig = {
        Addresses = {
          Announce = [ ];
          NoAnnounce = [ ];
        };
        API = { HTTPHeaders = { Access-Control-Allow-Origin = [ "*" ]; }; };
        Discovery = { MDNS = { Enabled = true; }; };
        Routing = { Type = "dht"; };
      };
    };
  };
}
