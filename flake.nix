{
  description = "walkah's little city state";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # My stuff
    dotfiles = {
      url = "github:walkah/dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.flake-utils.follows = "flake-utils";
    };

    workon = {
      url = "github:walkah/workon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , deploy-rs
    , darwin
    , flake-utils
    , nixos-generators
    , home-manager
    , dotfiles
    , workon
    , ...
    }@inputs:
    let
      overlays = [
        (self: _super: {
          workon = workon.packages.${self.system}.default;
        })
      ];

      mkSystem = hostName: system: modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            home-manager.nixosModules.home-manager
            (_: {
              networking.hostName = hostName;
              nixpkgs.overlays = overlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            })
          ] ++ modules;
          specialArgs = inputs;
        };
      mkDarwin = hostName: system: modules:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            home-manager.darwinModules.home-manager
            (_: {
              networking.hostName = hostName;
              nixpkgs.overlays = overlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            })
          ] ++ modules;
          specialArgs = inputs;
        };
    in
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        darwin-local = pkgs.writeScriptBin "darwin-local" ''
          #!${pkgs.stdenv.shell}
          nix build .#darwinConfigurations.$(hostname -s).system
          ./result/sw/bin/darwin-rebuild switch --flake .
        '';

      in
      {

        packages = {
          digitalocean = nixos-generators.nixosGenerate {
            system = "x86_64-linux";
            format = "do";
            modules = [
              ./modules/base
              ./users
            ];
          };
        };

        devShells.default = pkgs.mkShell {
          name = "athens";
          buildInputs = [ darwin-local deploy-rs.packages.${system}.deploy-rs pkgs.nixpkgs-fmt pkgs.rnix-lsp pkgs.sops ];
        };

        formatter = pkgs.nixpkgs-fmt;
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
      homeConfigurations = {
        "walkah@epicurus" = dotfiles.homeConfigurations.aarch64-darwin.walkah;
        "walkah@heraclitus" = dotfiles.homeConfigurations.aarch64-darwin.walkah;
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
                dotfiles.homeConfigurations.x86_64-linux.walkah;
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
                dotfiles.homeConfigurations.x86_64-linux.walkah;
            };
          };
        };

        epicurus = {
          hostname = "epicurus";
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.aarch64-darwin.activate.darwin self.darwinConfigurations.epicurus;
            };
            walkah = {
              user = "walkah";
              path = deploy-rs.lib.aarch64-darwin.activate.home-manager dotfiles.homeConfigurations.aarch64-darwin.walkah;
            };
          };
        };
      };
    };
}
