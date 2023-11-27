{ pkgs, config, ... }: {
  sops.secrets.drone = {
    owner = "drone";
  };

  services = {
    postgresql = {
      ensureDatabases = [ "drone" ];
      ensureUsers = [
        {
          name = "drone";
          ensureDBOwnership = true;
        }
      ];
    };
    postgresqlBackup.databases = [ "drone" ];
  };

  systemd.services.drone = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      EnvironmentFile = [
        config.sops.secrets.drone.path
      ];
      Environment = [
        "DRONE_GITEA_SERVER=https://walkah.dev"
        "DRONE_DATABASE_DATASOURCE=postgres:///drone?host=/run/postgresql"
        "DRONE_DATABASE_DRIVER=postgres"
        "DRONE_SERVER_HOST=https://drone.walkah.dev"
        "DRONE_SERVER_PORT=:3030"
        "DRONE_SERVER_PROTO=https"
        "DRONE_USER_CREATE=username:walkah,admin:true"
      ];
      ExecStart = "${pkgs.drone}/bin/drone-server";
      User = "drone";
      Group = "drone";
    };
  };

  users.users.drone = {
    isSystemUser = true;
    createHome = true;
    group = "drone";
  };
  users.groups.drone = { };
}
