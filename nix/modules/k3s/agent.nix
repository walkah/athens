{
  imports = [ ./common.nix ];

  services.k3s = {
    role = "agent";
    serverAddr = "https://100.111.208.75:6443";
  };
}
