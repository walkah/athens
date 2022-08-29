{ config, lib, pkgs, ... }:

let cfg = config.services.gitea;
in
{
  users.users.git = {
    description = "Gitea Service";
    home = cfg.stateDir;
    useDefaultShell = true;
    group = "git";
    isSystemUser = true;
  };
  users.groups.git = { };

  services = {
    gitea = {
      enable = true;
      user = "git";
      domain = "walkah.dev";
      appName = "walkah forge";
      rootUrl = "https://walkah.dev/";
      httpAddress = "0.0.0.0";
      httpPort = 8003;
      lfs.enable = true;

      settings = {
        log.LEVEL = "Error";
        other.SHOW_FOOTER_VERSION = false;
        repository.DEFAULT_BRANCH = "main";
        server.SSH_DOMAIN = "git.walkah.dev";
        service.DISABLE_REGISTRATION = true;
        session.COOKIE_SECURE = true;
      };

      dump.enable = false;

      database = {
        type = "postgres";
        user = "git";
      };
    };
    postgresqlBackup.databases = [ "gitea" ];
  };
}
