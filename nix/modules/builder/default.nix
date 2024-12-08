_: {
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "plato";
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        maxJobs = 6;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
          "kvm"
        ];
      }
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
