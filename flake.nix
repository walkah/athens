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

    # My stuff
    dotfiles = {
      url = "github:walkah/dotfiles";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        flake-utils.follows = "flake-utils";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
    };

    workon = {
      url = "github:walkah/workon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, deploy-rs, pre-commit-hooks, workon, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          checks = import ./nix/checks.nix { inherit self pkgs deploy-rs system pre-commit-hooks; };
          devShells = import ./nix/shells.nix { inherit self pkgs system; };
          formatter = pkgs.nixpkgs-fmt;
        })
    // {
      hosts = import ./nix/hosts.nix;
      overlays.default = nixpkgs.lib.composeManyExtensions [
        workon.overlays.default
      ];

      darwinConfigurations = import ./nix/darwin.nix inputs;
      homeConfigurations = import ./nix/home.nix inputs;
      nixosConfigurations = import ./nix/nixos.nix inputs;
      deploy = import ./nix/deploy.nix inputs;
    };
}
