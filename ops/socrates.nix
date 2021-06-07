{
  network = { description = "Digital Ocean droplet"; };

  socrates = { config, pkgs, ... }: {
    imports = [ ../hosts/socrates/configuration.nix ];
    networking.hostName = "socrates";
    nixpkgs.system = "x86_64-linux";

    deployment.targetHost = "167.99.176.10";
    deployment.targetUser = "root";
  };
}
