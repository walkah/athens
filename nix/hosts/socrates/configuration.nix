{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ../../modules/base/nixos.nix

    ../../modules/akkoma
    ../../modules/akkoma/nginx.nix
    ../../modules/coredns
    ../../modules/code-server/nginx.nix
    ../../modules/drone/nginx.nix
    ../../modules/gitea/nginx.nix
    ../../modules/home-assistant/nginx.nix
    ../../modules/ipfs/gateway.nix
    ../../modules/matrix/nginx.nix
    ../../modules/minecraft/proxy.nix
    ../../modules/sops
  ];

  boot.tmp.cleanOnBoot = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  networking = {
    hostName = "socrates";
    firewall = {
      allowPing = true;
      allowedTCPPorts = [
        80
        443
      ];
      trustedInterfaces = [ "tailscale0" ];
      checkReversePath = "loose";
    };
  };

  nix = {
    settings.trusted-users = [
      "@wheel"
      "root"
    ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
    acme.acceptTerms = true;
    acme.defaults.email = "walkah@walkah.net";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
  ];

  environment.systemPackages = with pkgs; [ ipfs-migrator ];

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
  };
}
