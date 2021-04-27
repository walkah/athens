{
  network = { description = "RPi 4 cluster"; };

  agent = { config, pkgs, ... }: {
    imports = [ ../hosts/aristotle/configuration.nix ];
    networking.hostName = "agent";
    nixpkgs.system = "aarch64-linux";

    deployment.targetHost = "192.168.6.200";
    deployment.targetUser = "root";
  };

  form = { config, pkgs, ... }: {
    imports = [ ../hosts/aristotle/configuration.nix ];
    networking.hostName = "form";
    nixpkgs.system = "aarch64-linux";

    deployment.targetHost = "192.168.6.201";
    deployment.targetUser = "root";
  };

  matter = { config, pkgs, ... }: {
    imports = [ ../hosts/aristotle/configuration.nix ];
    networking.hostName = "matter";
    nixpkgs.system = "aarch64-linux";

    deployment.targetHost = "192.168.6.202";
    deployment.targetUser = "root";
  };

  purpose = { config, pkgs, ... }: {
    imports = [ ../hosts/aristotle/configuration.nix ];
    networking.hostName = "purpose";
    nixpkgs.system = "aarch64-linux";

    deployment.targetHost = "192.168.6.203";
    deployment.targetUser = "root";
  };
}
