{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "hass.nerdhaus.ca" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://plato:8123";
          proxyWebsockets = true;
        };
      };
    };
  };
}
