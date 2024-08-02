{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Cloud
    awscli2
    # doppler TODO: waiting on https://github.com/NixOS/nixpkgs/pull/326008

    # Git / CI
    drone-cli
    mr
    tea

    # NodeJS
    nodejs

    # Golang
    go

    # k8s
    chart-testing
    k9s
    kind
    kubectl
    kubernetes-helm

    # Nix
    cachix
    nixd
    nixf
    nixpkgs-fmt

    # My stuff
    homestar
    workon
  ];
}
