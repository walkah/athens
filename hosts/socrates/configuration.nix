{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    <home-manager/nixos>
  ];

  boot.cleanTmpDir = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  networking.hostName = "socrates";
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.nameservers = [ "100.100.100.100" "1.1.1.1" ];
  networking.search = [ "walkah.net.beta.tailscale.net" ];

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
  home-manager.users.walkah = import /home/walkah/.config/nixpkgs/home.nix;

  system.autoUpgrade.enable = true;
  environment.systemPackages = with pkgs; [ ];

  programs.mosh.enable = true;
  programs.zsh.enable = true;

  services.openssh.enable = true;
  services.tailscale.enable = true;

  virtualisation.docker.enable = true;

  security.acme.acceptTerms = true;
  security.acme.email = "walkah@walkah.net";

  services.nginx = {
    enable = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."walkah.codes" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        proxyWebsockets = true;
      };
    };
  };

}
