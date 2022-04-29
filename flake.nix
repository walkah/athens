{
  description = "walkah's little city state";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, deploy-rs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              deploy-rs.packages.${system}.deploy-rs
              pkgs.sops
            ];
          };
        }
      )
    // {
      nixosConfigurations = {
        agent = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/aristotle/configuration.nix
            ({ config, ... }: {
              networking.hostName = "agent";
            })
          ];
        };

        form = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/aristotle/configuration.nix
            ({ config, ... }: {
              networking.hostName = "form";
            })
          ];
        };

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
      };
    };
}
