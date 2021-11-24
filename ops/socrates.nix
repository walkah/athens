{
  network = { description = "Digital Ocean droplet"; };

  socrates = { config, pkgs, ... }: {
    imports = [ ../hosts/socrates/configuration.nix ];
    networking.hostName = "socrates";
    nixpkgs.system = "x86_64-linux";

    deployment.targetHost = "socrates";
    deployment.targetUser = "root";
  };
}
