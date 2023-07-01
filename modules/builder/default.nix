{ config, nixpkgs, pkgs, ... }:
let
  dataDir = "/var/lib/darwin-builder";
  port = 33022;

  darwin-builder = nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [
      "${nixpkgs}/nixos/modules/profiles/macos-builder.nix"
      {
        system.nixos.revision = nixpkgs.lib.mkForce null;
        virtualisation.host.pkgs = pkgs;
        virtualisation.darwin-builder.hostPort = port;
        virtualisation.darwin-builder.workingDirectory = dataDir;
      }
    ];
  };
in
{
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "builder";
      systems = [ "aarch64-linux" ];
      maxJobs = 4;
      speedFactor = 2;
      supportedFeatures = [ "kvm" "benchmark" "big-parallel" ];
    }
    {
      hostName = "plato";
      systems = [ "x86_64-linux" ];
      maxJobs = 6;
      supportedFeatures = [ "benchmark" "big-parallel" "kvm" ];
    }
  ];
  nix.settings.builders-use-substitutes = true;

  # We can't/want to edit /var/root/.ssh/config so instead we create the config at another location and tell ssh to use that instead by modifying NIX_SSHOPTS
  environment.etc."nix/ssh_config".text = ''
    Host builder
      User builder
      HostName 127.0.0.1
      Port ${toString port}
      IdentityFile ${dataDir}/keys/builder_ed25519
    Host plato
      IdentityFile /var/root/.ssh/id_plato
  '';

  # Tell nix-daemon to use our custom SSH config
  nix.envVars = { NIX_SSHOPTS = "-F /etc/nix/ssh_config"; };

  launchd.daemons.darwin-builder = {
    command = "${darwin-builder.config.system.build.macos-builder-installer}/bin/create-builder";
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/var/log/darwin-builder.log";
      StandardErrorPath = "/var/log/darwin-builder.log";
    };
  };
}
