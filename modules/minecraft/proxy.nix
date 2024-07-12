_:
let
  dest_ip = "100.111.208.75";
  dest_port = 25565;
in
{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ dest_port ];
    };
    nat = {
      enable = true;
      internalInterfaces = [ "tailscale0" ];
      externalInterface = "eth0";
      forwardPorts = [
        {
          sourcePort = dest_port;
          proto = "tcp";
          destination = "${dest_ip}:${toString dest_port}";
        }
      ];
    };
  };

  services = {
    tailscale = {
      useRoutingFeatures = "server";
      extraUpFlags = [ "--stateful-filtering=false" ];
    };
  };
}
