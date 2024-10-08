{ ... }:
{
  imports = [
    ./homebrew.nix

    ../../modules/base/darwin.nix
    ../../modules/dev
    ../../modules/builder
  ];

  nixpkgs.config.allowBroken = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [ emacs-macport ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "left";
      };
    };
  };
}
