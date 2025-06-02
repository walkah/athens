{
  description = "walkah's little city state";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";

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
      url = "github:cachix/git-hooks.nix";
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
      pre-commit-hooks,
      systems,
      ...
    }@inputs:
    let
      forAllSystems =
        fn: nixpkgs.lib.genAttrs (import systems) (system: fn system nixpkgs.legacyPackages.${system});
    in
    {
      checks = forAllSystems (
        system: pkgs:
        import ./nix/checks.nix {
          inherit
            self
            pkgs
            pre-commit-hooks
            system
            ;
        }
      );
      devShells = forAllSystems (system: pkgs: import ./nix/shells.nix { inherit self pkgs system; });
      formatter = forAllSystems (_: pkgs: pkgs.nixfmt-tree);
    }
    // {
      hosts = import ./nix/hosts.nix;
      overlays.default = nixpkgs.lib.composeManyExtensions [ ];

      darwinConfigurations = import ./nix/darwin.nix inputs;
      nixosConfigurations = import ./nix/nixos.nix inputs;

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
