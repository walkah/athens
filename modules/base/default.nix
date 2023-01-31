{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    inetutils
    vim
  ];
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      persistent = true;
    };

    settings = {
      auto-optimise-store = true;

      substituters = [
        "https://walkah.cachix.org"
      ];

      trusted-users = [ "root" "walkah" ];

      trusted-public-keys = [
        "walkah.cachix.org-1:D8cO78JoJC6UPV1ZMgd1V5znpk3jNUERGIeAKN15hxo="
      ];
    };
  };
}
