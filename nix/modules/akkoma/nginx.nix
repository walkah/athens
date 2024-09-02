_:
{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.social" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:4000";
          proxyWebsockets = true;
        };
      };
    };
  };
}
