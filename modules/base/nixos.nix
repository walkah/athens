{ config, ... }: {

  imports = [ ./common.nix ];

  nix = {
    gc = {
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings = {
      auto-optimise-store = true;

      trusted-users = [ "root" "walkah" ];
    };
  };

  programs = {
    mosh.enable = true;
  };

  system = {
    autoUpgrade = {
      enable = true;
      flake = "github:walkah/athens#${config.networking.hostName}";
      dates = "daily";
      randomizedDelaySec = "5m";
    };
    stateVersion = "23.05";
  };
}
