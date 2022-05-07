{ config, lib, pkgs, ... }:

let
  peers = [
    {
      ID = "12D3KooWMQSgdfa4tUrDhkFx4zP3ZpgT1ryj9KH5RGUae62Vsc7y";
      Addrs = [ "/ip4/100.95.167.126/tcp/4001" ];
    }
    {
      ID = "12D3KooWMqSiDukubKNKrK7J4PaF3mfNnZFVAd3Lh7qj3Y3e5bcN";
      Addrs = [ "/ip4/100.87.220.71/tcp/4001" ];

    }
    {
      ID = "12D3KooWGmNRyqP969QbyP8NLVRZNK2i6yCcP6N6N2r2DCG4H34v";
      Addrs = [ "/ip4/100.126.255.109/tcp/4001" ];

    }
    {
      ID = "12D3KooWFkR8nsG5pzffoAfMzmwBcSakXxnogVa6inRxUbpfN5ua";
      Addrs = [ "/ip4/100.74.59.80/tcp/4001" ];

    }
  ];
in
{
  imports = [ ./default.nix ];

  environment.systemPackages = with pkgs; [ ipfs-migrator ];

  networking.firewall = {
    allowedTCPPorts = [ 4001 ];
    allowedUDPPorts = [ 4001 ];
  };
  services = {
    ipfs = {
      enable = true;
      extraConfig = {
        Peering = { Peers = peers; };
        Swarm = { AddrFilters = null; };
      };
    };
    nginx = {
      virtualHosts."walkah.cloud" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = { proxyPass = "http://127.0.0.1:8080"; };
      };
    };
  };
}
