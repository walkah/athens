_: {

  nix = {
    configureBuildUsers = true;

    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
    };
    settings = {
      auto-optimise-store = true;

      substituters = [
        "https://walkah.cachix.org"
      ];

      trusted-users = [ "root" "@admin" ];

      trusted-public-keys = [
        "walkah.cachix.org-1:D8cO78JoJC6UPV1ZMgd1V5znpk3jNUERGIeAKN15hxo="
      ];
    };
  };

  environment.etc = {
    "sudoers.d/walkah".text = ''
      walkah   ALL = (ALL) NOPASSWD: ALL
    '';
  };

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    global = {
      brewfile = true;
      lockfiles = false;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    haskellPackages = pkgs.haskellPackages.override {
      overrides = _self: super: {
        niv = pkgs.haskell.lib.overrideCabal super.niv (_drv: {
          enableSeparateBinOutput = false;
        });
      };
    };
  };
}
