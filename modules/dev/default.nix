{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs

    # Elixir
    elixir
    elixir_ls

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
