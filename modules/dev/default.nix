{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs29

    # Cloud
    awscli2

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
    nil
    niv
    nixfmt
    nixpkgs-fmt

    # Node/JS
    deno
    nodejs
    yarn

    # Rust
    rustup

    # My stuff
    workon
  ];
}
