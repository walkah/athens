{ config, pkgs, ... }:
{
  imports = [
    ./homebrew.nix

    ../../modules/base/darwin.nix
    ../../modules/dev
    ../../modules/builder

    ../../services/ipfs-darwin.nix
  ];

  nixpkgs.config.allowBroken = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ emacs ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services.lorri.enable = true;
  services.ipfs = {
    enable = true;
    package = pkgs.kubo_carmirror;
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "left";
      };
    };
  };
}
