{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Cloud
    awscli2
    google-cloud-sdk
    doppler

    # Git / CI
    drone-cli
    mr
    tea

    # NodeJS
    bun
    nodejs
    pnpm

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
  ];
}