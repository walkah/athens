{ lib, pkgs, ... }:

{
  users.users.walkah =
    {
      home = if pkgs.stdenv.isDarwin then "/Users/walkah" else "/home/walkah";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8YMax7PGIrcPNIHkpuNRFgn3HJK6Wepm+ycZWO6jfR walkah@walkah-ipadpro11"
      ];
    }
    // lib.optionalAttrs pkgs.stdenv.isLinux {
      extraGroups = [
        "wheel"
        "docker"
      ];
      group = "walkah";
      isNormalUser = true;
    };
  users.groups.walkah = { };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.walkah = import ./home.nix;
  };
}
