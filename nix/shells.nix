{
  system,
  pkgs,
  self,
  ...
}:
{
  default = pkgs.mkShell {
    name = "athens";
    buildInputs = with pkgs; [
      deadnix
      doctl
      nh
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
