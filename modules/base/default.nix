{ pkgs, ... }: {

  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    inetutils
    vim
  ];
  nix = {
    gc = {
      persistent = true;
    };

    settings = {
      trusted-users = [ "root" "walkah" ];
    };
  };
}
