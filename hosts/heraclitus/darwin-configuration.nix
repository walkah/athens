{ config, lib, pkgs, dotfiles, ... }:
{
  imports = [
    ./homebrew.nix

    ../../modules/base/darwin.nix
    ../../modules/builder
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [ emacs-nox vim ghc go gopls niv rustup stack ];
  environment.systemPackages = with pkgs; [ deno elixir emacs go niv nodejs rustup ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  users.nix.configureBuildUsers = true;
  users.users.walkah = {
    home = "/Users/walkah";
    shell = pkgs.zsh;
  };

  home-manager.users.walkah = import "${dotfiles}/home.nix";

  nix = {
    package = pkgs.nix;

    trustedUsers = [ "root" "@admin" ];

    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
      experimental-features = nix-command flakes
    '';
  };

  services.lorri.enable = true;

  programs = {
    zsh = {
      enable = true;
      promptInit = "";
    };
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "left";
      };
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}