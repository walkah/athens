{ config, ... }:

{
  services.traefik = {
    enable = true;
    group = "docker";
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
  systemd.services.traefik = {
    serviceConfig = {
      EnvironmentFile = config.sops.secrets.traefik.path;
    };
  };

  sops.secrets.traefik = {
    owner = "traefik";
  };
}
