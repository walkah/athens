{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "hass.nerdhaus.ca" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.111.208.75:8123";
          proxyWebsockets = true;
        };
      };
    };
  };
}
