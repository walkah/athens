{ pkgs, config, ... }: {

  nix = {
    configureBuildUsers = true;

    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
      experimental-features = nix-command flakes
    '';

    settings = {
      trusted-users = [ "root" "@admin" ];
    };
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

  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
      rm -rf /Applications/Nix
      mkdir -p /Applications/Nix
      for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
        src="$(/usr/bin/stat -f%Y "$app")"
        cp -r "$src" /Applications/Nix
      done
    ''
  );
}
