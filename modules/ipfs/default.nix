{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ipfs-migrator ];

  services = {
    kubo = {
      enable = true;
      settings = {
        Addresses = {
          Announce = [ ];
          API = "/ip4/0.0.0.0/tcp/5001";
          Gateway = "/ip4/0.0.0.0/tcp/8080";
          NoAnnounce = [ ];
          Swarm = [
            "/ip4/0.0.0.0/tcp/4001"
            "/ip6/::/tcp/4001"
            "/ip4/0.0.0.0/udp/4001/quic"
            "/ip6/::/udp/4001/quic"
          ];
        };
        API = { HTTPHeaders = { Access-Control-Allow-Origin = [ "*" ]; }; };
        Discovery = { MDNS = { Enabled = true; }; };
        Routing = { Type = "dht"; };
      };
    };
  };
}
