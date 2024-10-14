{ config, pkgs, ... }: {

  imports = [ ./common.nix ../monitoring ../../users ];

  documentation = {
    enable = false;
  };

  environment.systemPackages = with pkgs; [
    htop
    inetutils
    vim
  ];

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
      dates = "hourly";
      flags = [ "--option" "tarball-ttl" "0" ];
    };
    stateVersion = "23.05";
  };
}
