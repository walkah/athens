_:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.111.208.75:8003";
          proxyWebsockets = true;
          extraConfig = ''
            client_max_body_size 0;
          '';
        };
      };
    };
  };
}
