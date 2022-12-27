{ pkgs, ... }:
let
  dest_ip = "100.111.208.75";
in
{
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  networking.firewall.allowedTCPPorts = [ 25565 ];

  networking.firewall.extraCommands = ''
    IPTABLES=${pkgs.iptables}/bin/iptables
    "$IPTABLES" -t nat -A PREROUTING -p tcp --dport 25565 -j DNAT --to-destination ${dest_ip}:25565
    "$IPTABLES" -t nat -A POSTROUTING -j MASQUERADE
  '';
}
