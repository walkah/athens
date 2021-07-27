{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.codes" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://plato:8080";
          proxyWebsockets = true;
        };
      };
    };
  };
}
