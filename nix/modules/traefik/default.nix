{ config, ... }:

{
  services.traefik = {
    enable = true;
    group = "docker";
    environmentFiles = [
      config.sops.secrets.traefik.path
    ];
    staticConfigOptions = {
      api = {
        dashboard = true;
        insecure = true;
      };
      certificatesResolvers = {
        myresolver = {
          acme = {
            email = "walkah@walkah.net";
            storage = "/var/lib/traefik/acme.json";
            dnsChallenge = {
              provider = "cloudflare";
            };
          };
        };
      };
      entryPoints = {
        web = {
          address = ":80";
          http = {
            redirections = {
              entryPoint = {
                to = "websecure";
                scheme = "https";
              };
            };
          };
        };
        websecure = {
          address = ":443";
        };
      };
      providers = {
        docker = { };
      };
    };
  };

  sops.secrets.traefik = {
    owner = "traefik";
  };
}
