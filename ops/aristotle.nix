{
  network = { description = "RPi 4 cluster"; };

  agent = { config, pkgs, ... }: {
    imports = [ ../hosts/aristotle/configuration.nix ];
    networking.hostName = "agent";
    nixpkgs.system = "aarch64-linux";

    deployment.targetHost = "agent";
    deployment.targetUser = "root";
  };

  form = { config, pkgs, ... }: {
    imports = [ ../hosts/aristotle/configuration.nix ];
    networking.hostName = "form";
    nixpkgs.system = "aarch64-linux";

    deployment.targetHost = "form";
    deployment.targetUser = "root";
  };

  matter = { config, pkgs, ... }: {
    imports = [ ../hosts/aristotle/configuration.nix ];
    networking.hostName = "matter";
    nixpkgs.system = "aarch64-linux";

    deployment.targetHost = "matter";
    deployment.targetUser = "root";
  };

  purpose = { config, pkgs, ... }: {
    imports = [ ../hosts/aristotle/configuration.nix ];
    networking.hostName = "purpose";
    nixpkgs.system = "aarch64-linux";

    deployment.targetHost = "purpose";
    deployment.targetUser = "root";
  };
}
