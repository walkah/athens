_:
{
  nix.distributedBuilds = true;
  nix.buildMachines = [{
    hostName = "plato";
    systems = [ "x86_64-linux" "aarch64-linux" ];
    maxJobs = 12;
    speedFactor = 2;
    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
  }];
}
