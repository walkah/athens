{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.social" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://plato:4000";
          proxyWebsockets = true;
        };
      };
    };
  };
}
