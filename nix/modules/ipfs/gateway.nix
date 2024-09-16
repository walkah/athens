{ pkgs, ... }:

let
  peers = [
    {
      ID = "12D3KooWMQSgdfa4tUrDhkFx4zP3ZpgT1ryj9KH5RGUae62Vsc7y";
      Addrs = [ "/ip4/100.95.167.126/tcp/4001" ];
    }
    {
      ID = "12D3KooWC5ncgKeJV2G6QBdGMkT2gLbeviaDxpYR7V6NVTsma3C5";
      Addrs = [ "/ip4/100.104.247.27/tcp/4001" ];

    }
    {
      ID = "12D3KooW9xeqfnnNWafiDkLXWjC5YdUnBrG5tJDd3tnm86kqVwhA";
      Addrs = [ "/ip4/100.95.77.67/tcp/4001" ];

    }
    {
      ID = "12D3KooWLYPckqA4JACJ4vioWc4tYuPjmfLMbgviECnWqazjSgK9";
      Addrs = [ "/ip4/100.117.49.15/tcp/4001" ];

    }
  ];
in
{
  imports = [ ./default.nix ];

  environment.systemPackages = with pkgs; [ ipfs-migrator ];

  environment.etc = {
    "ipfs/denylists/badbits.deny".source = ./badbits.deny;
  };

  networking.firewall = {
    allowedTCPPorts = [ 4001 ];
    allowedUDPPorts = [ 4001 ];
  };
  services = {
    kubo = {
      enable = true;
      settings = {
        Discovery = { MDNS = { Enabled = false; }; };
        Peering = { Peers = peers; };
        Swarm = { AddrFilters = null; };
      };
    };
    nginx = {
      # IPFS Gateway
      virtualHosts."walkah.cloud" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = { proxyPass = "http://127.0.0.1:8080"; };
      };

      # Hosted Sites
      virtualHosts."walkah.net" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = { proxyPass = "http://127.0.0.1:8080"; };
        serverAliases = [
          "www.walkah.net"
        ];
      };
    };
  };
}
