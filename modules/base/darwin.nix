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
      trusted-users = [ "root" "@admin" ];
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
}
