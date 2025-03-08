{
  imports = [ ./common.nix ];
  services.k3s = {
    role = "server";
    clusterInit = true;
  };
}
