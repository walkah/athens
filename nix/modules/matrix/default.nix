{ config, pkgs, ... }:

{
  services = {
    postgresql = {
      enable = true;
      initialScript = pkgs.writeText "synapse-init.sql" ''
        CREATE ROLE "matrix-synapse";
        CREATE DATABASE "matrix" WITH OWNER "matrix-synapse"
            TEMPLATE template0
            ENCODING 'UTF8'
            LC_COLLATE = "C"
            LC_CTYPE = "C";
      '';
    };
    postgresqlBackup.databases = [
      "matrix"
      "matrix-syncv3"
    ];

    matrix-synapse = {
      enable = true;
      settings = {
        server_name = "walkah.chat";
        public_baseurl = "https://matrix.walkah.chat";
        enable_metrics = true;
        enable_registration = false;
        database = {
          name = "psycopg2";
          args = {
            database = "matrix";
          };
        };
        listeners = [
          {
            bind_addresses = [
              "0.0.0.0"
            ];
            port = 8008;
            type = "http";
            tls = false;
            x_forwarded = true;
            resources = [
              {
                compress = false;
                names = [
                  "client"
                  "federation"
                ];
              }
            ];
          }
        ];
      };
      extraConfigFiles = [
        config.sops.secrets.matrix-registration-secret.path
      ];
    };
  };

  sops.secrets.matrix-registration-secret = {
    owner = "matrix-synapse";
  };
}
