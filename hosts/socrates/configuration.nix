{ pkgs, ... }:

let
  dotfiles = builtins.fetchTarball
    "https://github.com/walkah/dotfiles/archive/main.tar.gz";
in {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    <home-manager/nixos>

    ../../modules/coredns
    ../../modules/code-server/nginx.nix
    ../../modules/home-assistant/nginx.nix
    ../../modules/matrix/nginx.nix
  ];

  boot.cleanTmpDir = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  networking.hostName = "socrates";
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  security.sudo.wheelNeedsPassword = false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
  ];
  users.users = {
    walkah = {
      extraGroups = [ "wheel" "docker" ];
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8YMax7PGIrcPNIHkpuNRFgn3HJK6Wepm+ycZWO6jfR walkah@walkah-ipadpro11"
      ];
    };
  };
  home-manager.users.walkah = import "${dotfiles}/home.nix";

  system.autoUpgrade.enable = false;
  environment.systemPackages = with pkgs; [ ];

  programs.mosh.enable = true;
  programs.zsh.enable = true;

  security.acme.acceptTerms = true;
  security.acme.email = "walkah@walkah.net";

  walkah.coredns = {
    enable = true;
    addr = "100.103.57.96";
  };

  services = {
    nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
    };
    openssh = { enable = true; };
    prometheus = {
      enable = true;
      port = 9090;
      listenAddress = "100.103.57.96";
      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          openFirewall = true;
          port = 9100;
          listenAddress = "100.103.57.96";
        };
      };
    };
    tailscale = { enable = true; };
  };
}
