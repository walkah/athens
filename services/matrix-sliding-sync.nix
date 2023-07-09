{ config, lib, pkgs, options, ... }:
with lib;
let
  cfg = config.services.matrix-syncv3;
in
{
  options = {
    services.matrix-syncv3 = {
      enable = mkEnableOption "SyncV3 for matrix";
      package = mkPackageOption pkgs "matrix-sliding-sync" { };

      port = mkOption {
        type = types.int;
        default = 8088;
        description = ''
          The port to listen on.
        '';
      };

      environmentFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = ''
          Must contain the `SYNCV3_SECRET` environment variable. 
          Generated with ``openssl rand -hex 32``.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      postgresql = {
        ensureDatabases = [ "matrix-syncv3" ];
        ensureUsers = [{
          name = "matrix-syncv3";
          ensurePermissions."DATABASE \"matrix-syncv3\"" = "ALL PRIVILEGES";
        }];
      };
    };

    systemd.services.matrix-syncv3 = {
      after = [ "matrix-synapse.service" "postgresql.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        DynamicUser = true;
        StateDirectory = "matrix-syncv3";
        WorkingDirectory = "/var/lib/matrix-syncv3";
        Environment = [
          "SYNCV3_SERVER=https://matrix.walkah.chat"
          "SYNCV3_DB=postgresql:///matrix-syncv3?host=/run/postgresql"
          "SYNCV3_BINDADDR=0.0.0.0:${toString cfg.port}"
        ];
      };
      script = ''
        path=/var/lib/matrix-syncv3/secret
        [ -f $path ] || ${pkgs.openssl}/bin/openssl rand -hex 32 > $path
        export SYNCV3_SECRET=$(cat $path)
        exec ${cfg.package}/bin/syncv3
      '';
    };
  };
}
