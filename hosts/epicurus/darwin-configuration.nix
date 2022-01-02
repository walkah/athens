{ config, lib, pkgs, ... }:
let
  dotfiles = builtins.fetchTarball
    "https://github.com/walkah/dotfiles/archive/main.tar.gz";

in
{
  imports = [ <home-manager/nix-darwin> ./homebrew.nix ];

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

  nix = {
    package = pkgs.nix;

    trustedUsers = [ "root" "@wheel" ];

    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.packageOverrides = pkgs: {
    haskellPackages = pkgs.haskellPackages.override {
      overrides = self: super: {
        niv = pkgs.haskell.lib.overrideCabal super.niv (drv: {
          enableSeparateBinOutput = false;
        });
      };
    };
  };

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
