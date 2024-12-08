{ pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "matrix.walkah.chat" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.111.208.75:8008";
        };
      };

      "syncv3.walkah.chat" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.111.208.75:8088";
        };
      };

      "walkah.chat" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "= /.well-known/matrix/server".extraConfig =
            let
              server = {
                "m.server" = "matrix.walkah.chat:443";
              };
            in
            ''
              default_type application/json;
              add_header Access-Control-Allow-Origin *;
              return 200 '${builtins.toJSON server}';
            '';
          "= /.well-known/matrix/client".extraConfig =
            let
              client = {
                "m.homeserver" = {
                  "base_url" = "https://matrix.walkah.chat";
                };
                "org.matrix.msc3575.proxy" = {
                  "url" = "https://syncv3.walkah.chat";
                };
              };
            in
            ''
              default_type application/json;
              add_header Access-Control-Allow-Origin *;
              return 200 '${builtins.toJSON client}';
            '';
          "/" = {
            root = pkgs.element-web;
          };
        };
      };
    };
  };
}
