{ system, pkgs, self, ... }: {
  default = pkgs.mkShell {
    name = "athens";
    buildInputs = with pkgs; [
      deploy-rs
      deadnix
      doctl
      nixd
      nixf
      nixpkgs-fmt
      opentofu
      statix
      sops
    ];

    inherit (self.checks.${system}.pre-commit-check) shellHook;
  };
}
