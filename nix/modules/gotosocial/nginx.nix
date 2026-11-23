_:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "walkah.pub" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://100.111.208.75:8088";
          proxyWebsockets = true;
        };
      };
    };
  };
}
