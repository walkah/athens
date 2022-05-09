{
  description = "walkah's little city state";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
    deploy-rs.url = "github:serokell/deploy-rs";

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
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , deploy-rs
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
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
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
          buildInputs = [ deploy-rs.packages.${system}.deploy-rs pkgs.sops ];
        };
      }) // {
      nixosConfigurations = {
        # Aristotle
        agent = mkSystem "agent" "aarch64-linux"
          [ ./hosts/aristotle/configuration.nix ];
        form = mkSystem "form" "aarch64-linux"
          [ ./hosts/aristotle/configuration.nix ];
        matter = mkSystem "matter" "aarch64-linux"
          [ ./hosts/aristotle/configuration.nix ];
        purpose = mkSystem "purpose" "aarch64-linux"
          [ ./hosts/aristotle/configuration.nix ];

        plato =
          mkSystem "plato" "x86_64-linux" [ ./hosts/plato/configuration.nix ];
        socrates = mkSystem "socrates" "x86_64-linux"
          [ ./hosts/socrates/configuration.nix ];
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
            walkah = {
              user = "walkah";
              path = deploy-rs.lib.x86_64-linux.activate.home-manager
                dotfiles.homeConfigurations.x86_64-linux;
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
            walkah = {
              user = "walkah";
              path = deploy-rs.lib.x86_64-linux.activate.home-manager
                dotfiles.homeConfigurations.x86_64-linux;
            };
          };
        };
      };
    };
}
