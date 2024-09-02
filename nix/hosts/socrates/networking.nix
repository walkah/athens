{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    defaultGateway = "167.99.176.1";
    defaultGateway6 = "2604:a880:cad:d0::1";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce true;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          {
            address = "167.99.176.10";
            prefixLength = 20;
          }
          {
            address = "10.20.0.5";
            prefixLength = 16;
          }
        ];
        ipv6.addresses = [
          {
            address = "2604:a880:cad:d0::cda:5001";
            prefixLength = 64;
          }
          {
            address = "fe80::b885:79ff:fe71:134e";
            prefixLength = 64;
          }
        ];
        ipv4.routes = [{
          address = "167.99.176.1";
          prefixLength = 32;
        }];
        ipv6.routes = [{
          address = "2604:a880:cad:d0::1";
          prefixLength = 32;
        }];
      };

    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="ba:85:79:71:13:4e", NAME="eth0"
    ATTR{address}=="3e:02:2b:ed:5d:22", NAME="eth1"
  '';
}
