_:

{
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
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];

      trusted-public-keys = [
        "walkah.cachix.org-1:D8cO78JoJC6UPV1ZMgd1V5znpk3jNUERGIeAKN15hxo="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
  };

  programs.zsh.enable = true;
}
