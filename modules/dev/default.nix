{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs

    # Cloud 
    awscli2
    pulumi-bin

    # Elixir
    elixir
    elixir_ls

    # Git / CI
    drone-cli
    mr
    tea

    # Golang
    go
    gopls

    # Nix
    cachix
    devenv
    niv
    nixfmt
    nixpkgs-fmt
    rnix-lsp

    # Node/JS
    deno
    nodejs
    yarn

    # Rust
    rustup
    rust-analyzer

    # My stuff
    workon
  ];
}
