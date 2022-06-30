{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "drone.walkah.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.111.208.75:3030";
          proxyWebsockets = true;
        };
      };
    };
  };
}
