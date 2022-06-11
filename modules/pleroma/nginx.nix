{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.social" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.111.208.75:4000";
          proxyWebsockets = true;
        };
      };
    };
  };
}
