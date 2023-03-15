{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.ipfs;
in
{
  options = {
    services.ipfs = {
      enable = mkEnableOption "Enable kubo on darwin";

      package = mkOption {
        type = types.package;
        default = pkgs.kubo_carmirror;
        defaultText = literalExpression "pkgs.kubo";
        description = "The package to use for kubo";
      };

      logFile = mkOption {
        type = types.nullOr types.path;
        default = "/var/tmp/ipfs.log";
        description = "Absolute path to log stderr / stdout";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    launchd.user.agents.ipfs = {
      path = [ cfg.package ];
      script = ''
        if ! test -e $HOME/.ipfs/version; then
          ${cfg.package}/bin/ipfs init
        fi
        ${cfg.package}/bin/ipfs daemon --migrate
      '';
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Background";
        StandardErrorPath = cfg.logFile;
        StandardOutPath = cfg.logFile;
      };
    };
  };
}
