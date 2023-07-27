{ system, pkgs, self, ... }:
let
  darwin-local = pkgs.writeScriptBin "darwin-local" ''
    #!${pkgs.stdenv.shell}
    nix build .#darwinConfigurations.$(hostname -s).system
    ./result/sw/bin/darwin-rebuild switch --flake .
  '';
in
{
  default = pkgs.mkShell {
    name = "athens";
    buildInputs = with pkgs; [
      darwin-local
      deploy-rs.deploy-rs
      deadnix
      nil
      nixpkgs-fmt
      statix
      sops
    ];

    inherit (self.checks.${system}.pre-commit-check) shellHook;
  };
}
