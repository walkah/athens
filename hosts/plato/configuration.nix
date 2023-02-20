{ config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../users

    ../../modules/base
    ../../modules/coredns
    ../../modules/drone
    ../../modules/drone/runner-docker.nix
    ../../modules/gitea
    ../../modules/matrix
    ../../modules/minecraft
    ../../modules/pleroma
    ../../modules/postgresql
    ../../modules/sops
    ../../modules/traefik
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../../overlays) ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

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
    borgbackup.jobs."borgbase" = {
      paths = [
        "/var/lib"
        "/var/backup"
      ];
      exclude = [
        # very large paths
        "/var/lib/docker"
        "/var/lib/postgresql"
        "/var/lib/systemd"
      ];
      repo = "qxflzs92@qxflzs92.repo.borgbase.com:repo";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /root/borgbackup/passphrase";
      };
      environment.BORG_RSH = "ssh -i /root/borgbackup/ssh_key";
      compression = "auto,lzma";
      startAt = "daily";
    };
    grafana = {
      enable = true;
      settings = {
        server = {
          domain = "plato.walkah.lab";
          http_port = 2342;
          http_addr = "0.0.0.0";
        };
      };
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
}
