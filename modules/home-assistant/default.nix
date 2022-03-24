{ config, lib, pkgs, ... }:

{
  # Use the docker container because it's officially supported.
  virtualisation.oci-containers = {
    containers = {
      home-assistant = {
        image = "ghcr.io/home-assistant/home-assistant:2022.3.7";
        volumes =
          [ "/var/lib/hass:/config" "/etc/localtime:/etc/localtime:ro" ];
        extraOptions = [ "--privileged" "--network=host" ];
      };
    };
  };
}
