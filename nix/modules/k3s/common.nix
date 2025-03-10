{ config, ... }:
{
  services.k3s = {
    enable = false;
    tokenFile = config.sops.secrets.k3s-token.path;
  };
  sops.secrets.k3s-token = {
    owner = "root";
    mode = "0400";
  };
}
