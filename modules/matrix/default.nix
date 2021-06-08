{ config, lib, pkgs, ... }:

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

    matrix-synapse = {
      enable = true;
      server_name = "walkah.chat";
      enable_metrics = true;
      enable_registration = false;
      database_type = "psycopg2";
      database_args = { database = "matrix"; };

      listeners = [{
        port = 8008;
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [{
          compress = false;
          names = [ "client" "federation" ];
        }];
      }];
    };
  };
}
