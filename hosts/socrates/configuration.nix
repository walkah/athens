{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ../../nix/modules/base/nixos.nix

    ../../nix/modules/akkoma
    ../../nix/modules/akkoma/nginx.nix
    ../../nix/modules/coredns
    ../../nix/modules/code-server/nginx.nix
    ../../nix/modules/drone/nginx.nix
    ../../nix/modules/gitea/nginx.nix
    ../../nix/modules/home-assistant/nginx.nix
    ../../nix/modules/ipfs/gateway.nix
    ../../nix/modules/matrix/nginx.nix
    ../../nix/modules/minecraft/proxy.nix
    ../../nix/modules/sops
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

  environment.systemPackages = with pkgs; [ kubo-migrator ];

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
