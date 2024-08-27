{ pkgs, config, ... }:
let
  automount_opts = "uid=1000,gid=1000,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  inherit (config.sops) secrets;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../users
    ../../modules/base/nixos.nix

    ../../modules/coredns
    ../../modules/drone
    ../../modules/drone/runner-docker.nix
    ../../modules/gitea
    ../../modules/matrix
    ../../modules/minecraft
    ../../modules/postgresql
    ../../modules/sops
    ../../modules/traefik
  ];
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        # Use the systemd-boot EFI boot loader.
        enable = true;
        configurationLimit = 3;
      };
    };
    tmp.cleanOnBoot = true;
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";
  networking = {
    hostName = "plato"; # Define your hostname.
    useDHCP = false;
    interfaces = {
      enp10s0.useDHCP = true;
      enp9s0.useDHCP = true;
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5spf4diguK+w7iYLFr565++6DjHukWfvpN2ru9dCRk nixbuild"
  ];

  environment.systemPackages = with pkgs; [ cifs-utils pinentry weechat ];
  fileSystems = {
    "/mnt/downloads" = {
      device = "//parthenon/Downloads";
      fsType = "cifs";
      options = [
        "${automount_opts},credentials=${secrets.filesystems-parthenon.path}"
      ];
    };

    "/mnt/music" = {
      device = "//parthenon/Music";
      fsType = "cifs";
      options = [
        "${automount_opts},credentials=${secrets.filesystems-parthenon.path}"
      ];
    };
    "/mnt/video" = {
      device = "//parthenon/Video";
      fsType = "cifs";
      options = [
        "${automount_opts},credentials=${secrets.filesystems-parthenon.path}"
      ];
    };
  };


  power.ups = {
    enable = true;
    mode = "netserver";
    ups."cyberpower" = {
      description = "Cyberpower EC650LCD";
      driver = "usbhid-ups";
      port = "auto";
    };
    upsd = {
      enable = true;
      listen = [
        { address = "0.0.0.0"; }
      ];
    };
    users.upsmon = {
      passwordFile = secrets.upsmon.path;
      upsmon = "primary";
    };

    upsmon.monitor."cyberpower".user = "upsmon";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  sops.secrets = {
    filesystems-parthenon = { };
    upsmon = { };
  };

  services = {
    borgbackup.jobs."borgbase" = {
      paths = [
        "/var/backup"
      ];
      repo = "ssh://fk0o7077@fk0o7077.repo.borgbase.com/./repo";
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
    tailscale = {
      useRoutingFeatures = "server";
    };
  };

  walkah.coredns = { enable = true; };

  virtualisation.docker = {
    enable = true;
    # Clean docker images periodically
    autoPrune = {
      enable = true;
      flags = [ "--all" ];
    };
  };
}
