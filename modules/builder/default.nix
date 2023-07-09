{ config, nixpkgs, pkgs, ... }: {
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "plato";
      systems = [ "x86_64-linux" ];
      maxJobs = 6;
      supportedFeatures = [ "benchmark" "big-parallel" "kvm" ];
    }
  ];
  nix.linux-builder.enable = true;
}
