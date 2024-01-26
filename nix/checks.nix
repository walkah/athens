{ self, system, deploy-rs, pre-commit-hooks, ... }:
{
  pre-commit-check = pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      deadnix.enable = true;
      nixpkgs-fmt.enable = true;
      statix.enable = true;
    };
  };
} // (deploy-rs.lib.${system}.deployChecks self.deploy)
