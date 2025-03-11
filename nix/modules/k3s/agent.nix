_:
let
  hosts = import ../../hosts.nix;
in
{
  imports = [ ./common.nix ];

  services.k3s = {
    role = "agent";
    serverAddr = "https://${hosts.plato.address}:6443";
  };
}
