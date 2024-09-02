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
        "https://cache.garnix.io"
      ];

      trusted-public-keys = [
        "walkah.cachix.org-1:D8cO78JoJC6UPV1ZMgd1V5znpk3jNUERGIeAKN15hxo="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
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
