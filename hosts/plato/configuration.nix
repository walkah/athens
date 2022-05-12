{ config, pkgs, home-manager, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/coredns
    ../../modules/code-server
    ../../modules/gitea
    ../../modules/home-assistant
    ../../modules/matrix
    ../../modules/pleroma
    ../../modules/sops
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../../overlays) ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  networking.hostName = "plato"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.enp10s0.useDHCP = true;
  networking.interfaces.enp9s0.useDHCP = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5spf4diguK+w7iYLFr565++6DjHukWfvpN2ru9dCRk nixbuild"
  ];
  users.users.walkah = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8YMax7PGIrcPNIHkpuNRFgn3HJK6Wepm+ycZWO6jfR walkah@walkah-ipadpro11"
    ];
  };

  system.autoUpgrade.enable = false;
  environment.systemPackages = with pkgs; [ pinentry weechat ];

  fileSystems."/mnt/downloads" = {
    device = "192.168.6.100:/volume1/Downloads";
    fsType = "nfs";
  };
  fileSystems."/mnt/music" = {
    device = "192.168.6.100:/volume1/Music";
    fsType = "nfs";
  };
  fileSystems."/mnt/video" = {
    device = "192.168.6.100:/volume1/Video";
    fsType = "nfs";
  };

  power.ups = {
    enable = true;
    mode = "standalone";
    ups."cyberpower" = {
      description = "Cyberpower EC650LCD";
      driver = "usbhid-ups";
      port = "auto";
    };
  };

  programs.mosh.enable = true;
  programs.zsh = {
    enable = true;
    promptInit = "";
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "curses";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.tailscale.enable = true;
  services.keybase.enable = true;

  virtualisation.docker = {
    enable = true;
    # Clean docker images periodically
    autoPrune = {
      enable = true;
      flags = [ "--all" ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  walkah.coredns = { enable = true; };

  services = {
    grafana = {
      enable = true;
      domain = "plato.walkah.lab";
      port = 2342;
      addr = "0.0.0.0";
    };
    prometheus = {
      enable = true;
      port = 9090;
      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = 9100;
        };
      };

      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [{
            targets = [
              "plato:9100"
              "agent:9100"
              "form:9100"
              "matter:9100"
              "purpose:9100"
              "socrates:9100"
            ];
          }];
        }
        {
          job_name = "coredns";
          static_configs = [{ targets = [ "plato:9153" ]; }];
        }
        {
          job_name = "ipfs";
          metrics_path = "/debug/metrics/prometheus";
          static_configs = [{
            targets = [ "agent:5001" "form:5001" "matter:5001" "purpose:5001" ];
          }];
        }
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
