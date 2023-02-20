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
    };

    settings = {
      trusted-users = [ "root" "walkah" ];
    };
  };

  system.stateVersion = "23.05";
}
