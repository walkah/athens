{ config, lib, pkgs, dotfiles, ... }:
{
  imports = [
    ./homebrew.nix

    ../../modules/base/darwin.nix
    ../../modules/builder
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ emacs-nox vim ghc go gopls niv rustup stack ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  users.users.walkah = {
    home = "/Users/walkah";
    shell = pkgs.zsh;
  };

  home-manager.users.walkah = import "${dotfiles}/home.nix";

  nixpkgs.config.packageOverrides = pkgs: {
    haskellPackages = pkgs.haskellPackages.override {
      overrides = _self: super: {
        niv = pkgs.haskell.lib.overrideCabal super.niv (_drv: {
          enableSeparateBinOutput = false;
        });
      };
    };
  };

  services.lorri.enable = true;

  programs = {
    zsh = {
      enable = true;
      promptInit = "";
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
