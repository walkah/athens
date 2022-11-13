{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.ipfs;
in
{
  options = {
    services.ipfs = {
      enable = mkEnableOption "Enable kubo on darwin";

      logFile = mkOption {
        type = types.nullOr types.path;
        default = "/var/tmp/ipfs.log";
        description = "Absolute path to log all stderr and stdout";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ipfs ];

    launchd.user.agents.ipfs = {
      command = with pkgs; "${ipfs}/bin/ipfs daemon --migrate";
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Background";
        StandardOutPath = cfg.logFile;
        StandardErrorPath = cfg.logFile;
        EnvironmentVariables = { NIX_PATH = "nixpkgs=" + toString pkgs.path; };
      };
    };
  };
}
