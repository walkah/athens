{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Cloud
    awscli2
    doppler

    # Git / CI
    drone-cli
    mr
    tea

    # NodeJS
    nodejs

    # Golang
    go

    # Nix
    cachix
    nil
    nixpkgs-fmt

    # My stuff
    homestar
    workon
  ];
}
