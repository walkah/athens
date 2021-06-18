let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in pkgs.mkShell {
  name = "athens";
  buildInputs = [ pkgs.morph ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${sources.nixpkgs}:home-manager=${sources.home-manager}:."
  '';
}
