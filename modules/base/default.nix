_: {

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

  system.stateVersion = "23.05";
}
