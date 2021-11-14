let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in
pkgs.mkShell {
  name = "athens";
  buildInputs = [
    pkgs.age
    pkgs.morph
    pkgs.sops
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${sources.nixpkgs}:home-manager=${sources.home-manager}:."
  '';
}
