{ self, darwin, home-manager, dotfiles, ... }:
let
  mkDarwin = hostName: modules:
    let
      hostSystem = self.hosts.${hostName}.system;
    in
    darwin.lib.darwinSystem {
      system = hostSystem;
      modules = [
        home-manager.darwinModules.home-manager
        (_: {
          networking.hostName = hostName;
          nixpkgs.pkgs = self.pkgs.${hostSystem};
        })
      ] ++ modules;
      specialArgs = { inherit dotfiles home-manager; };
    };
in
{
  epicurus = mkDarwin "epicurus" [ ../hosts/epicurus/darwin-configuration.nix ];
  heraclitus = mkDarwin "heraclitus" [ ../hosts/heraclitus/darwin-configuration.nix ];
}
