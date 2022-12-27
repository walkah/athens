{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    inetutils
    vim
  ];
  nix = {
    gc = {
      automatic = true;
      persistent = true;
    };
  };
}
