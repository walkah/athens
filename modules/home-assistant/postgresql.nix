{ config, lib, pkgs, ... }:

{
  services = {
    postgresql = {
      ensureDatabases = [ "hass" ];
      ensureUsers = [{
        name = "hass";
        ensurePermissions = { "DATABASE hass" = "ALL PRIVILEGES"; };
      }];
    };
  };
}
