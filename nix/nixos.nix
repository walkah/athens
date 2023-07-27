{ self, dotfiles, nixpkgs, home-manager, nixos-hardware, sops-nix, ... }:
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
          nixpkgs.pkgs = self.pkgs.${hostSystem};
        })
      ] ++ modules;
      specialArgs = { inherit dotfiles nixos-hardware sops-nix; };
    };
in
{
  # Aristotle
  agent = mkSystem "agent" [ ../hosts/aristotle/configuration.nix ];
  form = mkSystem "form" [ ../hosts/aristotle/configuration.nix ];
  matter = mkSystem "matter" [ ../hosts/aristotle/configuration.nix ];
  purpose = mkSystem "purpose" [ ../hosts/aristotle/configuration.nix ];

  plato = mkSystem "plato" [ ../hosts/plato/configuration.nix ];
  socrates = mkSystem "socrates" [ ../hosts/socrates/configuration.nix ];
}
