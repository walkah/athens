{ pkgs, nixos-hardware, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../nix/modules/base/nixos.nix
    nixos-hardware.nixosModules.raspberry-pi-4
    ../../nix/modules/ipfs/cluster.nix
    # ../../nix/modules/k3s/agent.nix
    ../../nix/modules/sops
  ];

  boot = {
    # See: https://github.com/NixOS/nixos-hardware/issues/858
    initrd.systemd.tpm2.enable = false;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];

    kernelParams = [
      "cgroup_enable=memory"
      "cgroup_enable=cpuset"
      "cgroup_memory=1"
    ];

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  hardware.raspberry-pi = {
    firmware = {
      enable = true;
      uboot.enable = true;
    };
    "4".poe-hat = {
      enable = true;
    };
  };

  time.timeZone = "America/Toronto";
  networking = {
    useDHCP = true;
    firewall.enable = false;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
  ];

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];
  security.sudo.wheelNeedsPassword = false;
}
