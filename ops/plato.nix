{
  network = { description = "Main dev server"; };

  plato = { config, pkgs, ... }: {
    imports = [ ../hosts/plato/configuration.nix ];
    networking.hostName = "plato";
    nixpkgs.system = "x86_64-linux";

    deployment.targetHost = "plato";
    deployment.targetUser = "root";
  };
}
