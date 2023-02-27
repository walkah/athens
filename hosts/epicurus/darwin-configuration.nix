{ pkgs, ... }:
{
  imports = [
    ./homebrew.nix

    ../../modules/base/darwin.nix
    ../../modules/builder
    ../../modules/dev
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ emacs-nox vim ghc go gopls rustup stack ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  users.users.walkah = {
    home = "/Users/walkah";
    shell = pkgs.zsh;
  };

  services.lorri.enable = true;

  programs = {
    zsh = {
      enable = true;
      promptInit = "";
    };
  };
}
