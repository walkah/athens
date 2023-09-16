{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs29

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
