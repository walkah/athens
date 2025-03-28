{
  description = "walkah's little city state";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";
    flake-utils.url = "github:numtide/flake-utils";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      deploy-rs,
      pre-commit-hooks,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {
        checks = import ./nix/checks.nix {
          inherit
            self
            pkgs
            deploy-rs
            system
            pre-commit-hooks
            ;
        };
        devShells = import ./nix/shells.nix { inherit self pkgs system; };
        formatter = pkgs.nixfmt-rfc-style;
      }
    )
    // {
      hosts = import ./nix/hosts.nix;
      overlays.default = nixpkgs.lib.composeManyExtensions [ ];

      darwinConfigurations = import ./nix/darwin.nix inputs;
      nixosConfigurations = import ./nix/nixos.nix inputs;
      deploy = import ./nix/deploy.nix inputs;

      nixConfig = {
        extra-substituters = [
          "https://walkah.cachix.org"
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "walkah.cachix.org-1:D8cO78JoJC6UPV1ZMgd1V5znpk3jNUERGIeAKN15hxo="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
}
