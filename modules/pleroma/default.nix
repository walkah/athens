{ config, lib, pkgs, ... }:

{
  services = {
    pleroma = {
      enable = true;
      secretConfigFile = "/var/lib/pleroma/secrets.exs";
      configs = [
        (builtins.readFile ./config.exs)
      ];
    };
    postgresql = {
      ensureDatabases = [ "pleroma" ];
      ensureUsers = [{
        name = "pleroma";
        ensurePermissions = { "DATABASE pleroma" = "ALL PRIVILEGES"; };
      }];
    };
    postgresqlBackup.databases = [ "pleroma" ];
  };
}
