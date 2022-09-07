{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs

    # Elixir
    elixir

    # Golang
    go
    gopls

    # Node/JS
    deno
    nodejs
    yarn

    # Rust
    rustup
    rust-analyzer
  ];
}
