{ pkgs, nixos-hardware, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.raspberry-pi-4
    ../../modules/base/nixos.nix

    ../../modules/ipfs/cluster.nix
    ../../modules/sops
  ];

  hardware = {
    raspberry-pi."4".poe-hat.enable = true;
  };

  time.timeZone = "America/Toronto";
  networking = {
    # networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
    interfaces.wlan0.useDHCP = true;
    firewall.enable = false;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0mE4MyMnfd1b2nlBJT7kpZ6Vov+ILuGNfzdp5ZBNQe walkah@walkah.net"
  ];

  environment.systemPackages = with pkgs; [ libraspberrypi raspberrypi-eeprom ];
}
