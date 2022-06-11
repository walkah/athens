{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.codes" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.66.26.116:8080";
          proxyWebsockets = true;
        };
      };
    };
  };
}
