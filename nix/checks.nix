{ self, system, pre-commit-hooks, ... }:
with self.pkgs.${system};
{
  pre-commit-check = pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      deadnix.enable = true;
      nixpkgs-fmt.enable = true;
      statix.enable = true;
    };
  };
} // (deploy-rs.lib.deployChecks self.deploy)
