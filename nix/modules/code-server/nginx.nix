_:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.codes" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.75.26.104:8080";
          proxyWebsockets = true;
        };
      };
    };
  };
}
