{ system, pkgs, self, ... }: {
  default = pkgs.mkShell {
    name = "athens";
    buildInputs = with pkgs; [
      deploy-rs.deploy-rs
      deadnix
      doctl
      nil
      nixpkgs-fmt
      statix
      sops
      terraform
    ];

    inherit (self.checks.${system}.pre-commit-check) shellHook;
  };
}
