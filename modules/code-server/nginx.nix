{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.codes" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://epicurus:8080";
          proxyWebsockets = true;
        };
      };
    };
  };
}
