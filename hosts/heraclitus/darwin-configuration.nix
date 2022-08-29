{ config, lib, pkgs, dotfiles, ... }:
{
  imports = [
    ./homebrew.nix

    ../../modules/base/darwin.nix
    ../../modules/builder
  ];

  nixpkgs.config.allowBroken = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ emacs ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  users.users.walkah = {
    home = "/Users/walkah";
    shell = pkgs.zsh;
  };

  home-manager.users.walkah = import "${dotfiles}/home.nix";

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
