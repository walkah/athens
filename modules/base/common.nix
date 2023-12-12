{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dogdns
    htop
    inetutils
    vim
  ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
    };

    settings = {
      substituters = [
        "https://walkah.cachix.org"
      ];

      trusted-public-keys = [
        "walkah.cachix.org-1:D8cO78JoJC6UPV1ZMgd1V5znpk3jNUERGIeAKN15hxo="
      ];
    };
  };

  programs = {
    zsh = {
      enable = true;
      promptInit = "";
    };
  };
}
