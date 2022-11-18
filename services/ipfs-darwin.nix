{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.ipfs;
in
{
  options = {
    services.ipfs = {
      enable = mkEnableOption "Enable kubo on darwin";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ipfs ];

    launchd.user.agents.ipfs = {
      path = [ pkgs.ipfs ];
      script = ''
        if ! test -e $HOME/.ipfs/version; then
          ipfs init
        fi
        ipfs daemon --migrate
      '';
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
  };
}
