{ self, pkgs, system, pre-commit-hooks, ... }:
{
  pre-commit-check = pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      deadnix.enable = true;
      nixpkgs-fmt.enable = true;
      statix.enable = true;
    };
  };
} // (pkgs.deploy-rs.lib.deployChecks self.deploy)
