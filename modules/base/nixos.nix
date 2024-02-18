{ config, ... }: {

  imports = [ ./common.nix ../monitoring ];

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

  services = {
    openssh.enable = true;
    tailscale.enable = true;
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
