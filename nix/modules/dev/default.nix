{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nix
    cachix
    nixd
    nixf
    nixfmt
  ];
}
