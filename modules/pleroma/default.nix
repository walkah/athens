{ config, lib, pkgs, ... }:

{
  services = {
    pleroma = {
      enable = true;
      configs = [ "import Config" ];
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
