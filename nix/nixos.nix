{ self, nixpkgs, home-manager, raspberry-pi-nix, sops-nix, ... }:
let
  mkSystem = hostName: modules:
    let
      hostSystem = self.hosts.${hostName}.system;
    in
    nixpkgs.lib.nixosSystem {
      system = hostSystem;
      modules = [
        home-manager.nixosModules.home-manager
        (_: {
          networking.hostName = hostName;
          nixpkgs.overlays = [ self.overlays.default ];
          nixpkgs.config.allowUnfree = true;
        })
      ] ++ modules;
      specialArgs = { inherit raspberry-pi-nix sops-nix; };
    };
in
{
  # Aristotle
  agent = mkSystem "agent" [ ./hosts/aristotle/configuration.nix ];
  form = mkSystem "form" [ ./hosts/aristotle/configuration.nix ];
  matter = mkSystem "matter" [ ./hosts/aristotle/configuration.nix ];
  purpose = mkSystem "purpose" [ ./hosts/aristotle/configuration.nix ];

  plato = mkSystem "plato" [ ./hosts/plato/configuration.nix ];
  socrates = mkSystem "socrates" [ ./hosts/socrates/configuration.nix ];
}
