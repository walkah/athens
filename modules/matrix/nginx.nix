{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "matrix.walkah.chat" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = { proxyPass = "http://plato:8008"; };
      };

      "walkah.chat" = {
        forceSSL = true;
        enableACME = true;
        locations."= /.well-known/matrix/server".extraConfig =
          let server = { "m.server" = "matrix.walkah.chat:443"; };
          in ''
            default_type application/json;
            add_header Access-Control-Allow-Origin *;
            return 200 '${builtins.toJSON server}';
          '';
        locations."= /.well-known/matrix/client".extraConfig = let
          client = {
            "m.homeserver" = { "base_url" = "https://matrix.walkah.chat"; };
          };
        in ''
          default_type application/json;
          add_header Access-Control-Allow-Origin *;
          return 200 '${builtins.toJSON client}';
        '';
        locations."/" = { root = pkgs.element-web; };
      };
    };
  };
}
