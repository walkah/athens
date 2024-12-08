{ config, ... }:

let
  cfg = config.services.gitea;
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
      appName = "walkah forge";
      lfs.enable = true;

      settings = {
        log = {
          LEVEL = "Error";
        };
        other = {
          SHOW_FOOTER_VERSION = false;
        };
        repository = {
          DEFAULT_BRANCH = "main";
        };
        server = {
          DOMAIN = "walkah.dev";
          HTTP_ADDR = "0.0.0.0";
          HTTP_PORT = 8003;
          ROOT_URL = "https://walkah.dev/";
          SSH_DOMAIN = "git.walkah.dev";
        };
        service = {
          DISABLE_REGISTRATION = true;
        };
        session = {
          COOKIE_SECURE = true;
        };
      };

      dump.enable = false;

      database = {
        createDatabase = false;
        type = "postgres";
        name = "gitea";
        socket = "/run/postgresql";
        user = "git";
      };
    };
    postgresql = {
      ensureDatabases = [ "gitea" ];
      ensureUsers = [
        {
          name = "git";
        }
      ];
    };
    postgresqlBackup.databases = [ "gitea" ];
  };
}
