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
            add_header Content-Type application/json;
            return 200 '${builtins.toJSON server}';
          '';
        locations."/" = { root = pkgs.element-web; };
      };
    };
  };
}
