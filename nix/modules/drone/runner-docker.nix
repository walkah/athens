{ pkgs, config, ... }: {
  systemd.services.drone-runner-docker = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Environment = [
      ];
      EnvironmentFile = [
        config.sops.secrets.drone.path
      ];
      ExecStart = "${pkgs.drone-runner-docker}/bin/drone-runner-docker";
      User = "drone-runner-docker";
      Group = "drone-runner-docker";
    };
  };

  users.users.drone-runner-docker = {
    isSystemUser = true;
    group = "drone-runner-docker";
    extraGroups = [ "docker" ];
  };
  users.groups.drone-runner-docker = { };
}
