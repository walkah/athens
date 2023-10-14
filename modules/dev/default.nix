{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Cloud
    awscli2

    # Git / CI
    drone-cli
    mr
    tea

    # Nix
    cachix
    nil
    nixpkgs-fmt

    # My stuff
    workon
  ];
}
