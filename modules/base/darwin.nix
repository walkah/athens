{ pkgs, config, ... }: {
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
