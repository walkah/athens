{
  imports = [ ./common.nix ];

  services.k3s = {
    role = "agent";
    serverAddr = "https://<ip of first node>:6443";
  };
}
