{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.homestar;

  format = pkgs.formats.toml { };
  configFile = format.generate "homestar.toml" cfg.settings;
in
{
  options.services.homestar = {
    enable = mkEnableOption "homestar";

    package = mkPackageOption pkgs "homestar" { };

    settings = mkOption {
      inherit ((pkgs.formats.json { })) type;
      default = { };
      description = "Homestar settings";
    };

    user = mkOption {
      type = types.str;
      default = "homestar";
      description = "User under which the Homestar daemon runs";
    };

    group = mkOption {
      type = types.str;
      default = "homestar";
      description = "Group under which the Homestar daemon runs";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/homestar";
      description = "Homestar data directory";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package pkgs.sqlite ];
    networking.firewall = {
      allowPing = true;
      allowedTCPPorts = [
        1337
        3030
        4000
        7001
      ];
      allowedUDPPorts = [
        7001
      ];
    };

    users.users = mkIf (cfg.user == "homestar") {
      homestar = {
        inherit (cfg) group;
        home = cfg.dataDir;
        createHome = true;
        isSystemUser = true;
        description = "Homestar daemon user";
      };
    };

    users.groups = mkIf (cfg.group == "homestar") {
      homestar = { };
    };

    systemd.services.homestar = {
      description = "Homestar daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/homestar start --config ${configFile}";
        Restart = "always";
        User = cfg.user;
        Group = cfg.group;
        WorkingDirectory = cfg.dataDir;
      };
    };
  };
}

