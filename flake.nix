{
  description = "walkah's little city state";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
    deploy-rs.url = "github:serokell/deploy-rs";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My stuff
    dotfiles = {
      url = "github:walkah/dotfiles";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , deploy-rs
    , darwin
    , flake-utils
    , home-manager
    , sops-nix
    , dotfiles
    , ...
    }@inputs:
    let
      mkSystem = hostName: system: modules:
        nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            home-manager.nixosModules.home-manager
            ({ config, ... }: {
              networking.hostName = hostName;
            })
          ] ++ modules;
          specialArgs = inputs;
        };
      mkDarwin = hostName: system: modules:
        darwin.lib.darwinSystem {
          system = system;
          modules = [
            home-manager.darwinModules.home-manager
            ({ config, ... }: {
              networking.hostName = hostName;
            })
          ] ++ modules;
          specialArgs = inputs;
        };
    in
    flake-utils.lib.eachDefaultSystem
      (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "athens";
          buildInputs = [ deploy-rs.packages.${system}.deploy-rs pkgs.nixpkgs-fmt pkgs.sops ];
        };
      }) // {
      nixosConfigurations = {
        # Aristotle
        agent = mkSystem "agent" "aarch64-linux" [ ./hosts/aristotle/configuration.nix ];
        form = mkSystem "form" "aarch64-linux" [ ./hosts/aristotle/configuration.nix ];
        matter = mkSystem "matter" "aarch64-linux" [ ./hosts/aristotle/configuration.nix ];
        purpose = mkSystem "purpose" "aarch64-linux" [ ./hosts/aristotle/configuration.nix ];

        plato = mkSystem "plato" "x86_64-linux" [ ./hosts/plato/configuration.nix ];
        socrates = mkSystem "socrates" "x86_64-linux" [ ./hosts/socrates/configuration.nix ];
      };
      darwinConfigurations = {
        epicurus = mkDarwin "epicurus" "aarch64-darwin" [ ./hosts/epicurus/darwin-configuration.nix ];
        heraclitus = mkDarwin "heraclitus" "aarch64-darwin" [ ./hosts/heraclitus/darwin-configuration.nix ];
      };

      deploy.nodes = {
        agent = {
          hostname = "agent";
          sshUser = "root";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos
              self.nixosConfigurations.agent;
          };
        };

        form = {
          hostname = "form";
          sshUser = "root";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos
              self.nixosConfigurations.form;
          };
        };

        matter = {
          hostname = "matter";
          sshUser = "root";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos
              self.nixosConfigurations.matter;
          };
        };

        purpose = {
          hostname = "purpose";
          sshUser = "root";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos
              self.nixosConfigurations.purpose;
          };
        };

        plato = {
          hostname = "plato";
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.plato;
            };
          };
        };

        socrates = {
          hostname = "socrates";
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.socrates;
            };
          };
        };
      };
    };
}
