{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ../../users

    ../../modules/coredns
    ../../modules/code-server/nginx.nix
    ../../modules/drone/nginx.nix
    ../../modules/gitea/nginx.nix
    ../../modules/home-assistant/nginx.nix
    ../../modules/ipfs/gateway.nix
    ../../modules/matrix/nginx.nix
    ../../modules/minecraft/proxy.nix
    ../../modules/pleroma/nginx.nix
  ];

  nixpkgs.overlays = [ (import ../../overlays) ];

  boot.cleanTmpDir = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  networking.hostName = "socrates";
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";

  nix = {
    settings.trusted-users = [ "@wheel" "root" ];
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
  ];

  system.autoUpgrade.enable = false;
  environment.systemPackages = with pkgs; [ ipfs-migrator ];

  programs.mosh.enable = true;
  programs.zsh.enable = true;

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "walkah@walkah.net";

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

  system.stateVersion = "22.05";
}
