{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Cloud
    awscli2

    # Git / CI
    drone-cli
    mr
    tea

    # NodeJS
    nodejs

    # Nix
    cachix
    nil
    nixpkgs-fmt

    # My stuff
    homestar
    workon
  ];
}
