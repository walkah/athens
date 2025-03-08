{ config, ... }:
{
  services.k3s = {
    enable = true;
    tokenFile = config.sops.secrets.k3s-token.path;
  };
  sops.secrets.k3s-token = {
    owner = "root";
    mode = "0400";
  };
}
