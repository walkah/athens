{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "athens";
  buildInputs = [ pkgs.morph ];
}
