{ pkgs, ... }: {

  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
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

  system.stateVersion = "23.05";
}
