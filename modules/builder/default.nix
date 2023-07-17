_: {
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "plato";
      systems = [ "x86_64-linux" "aarch64-linux" ];
      maxJobs = 6;
      supportedFeatures = [ "benchmark" "big-parallel" "kvm" ];
    }
  ];

  # TODO: waiting on fix for https://github.com/NixOS/nixpkgs/issues/243685
  # nix.linux-builder.enable = true;
}
 