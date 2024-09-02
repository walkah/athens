{ ... }:
{
  imports = [
    ./homebrew.nix

    ../../modules/base/darwin.nix
    ../../modules/builder
    ../../modules/dev
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [ emacs-nox ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  users.users.walkah.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
  ];
}
