_: {
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "plato";
        systems = [ "x86_64-linux" "aarch64-linux" ];
        maxJobs = 6;
        supportedFeatures = [ "benchmark" "big-parallel" "kvm" ];
      }
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
    linux-builder = {
      enable = true;
      ephemeral = true;
      maxJobs = 4;
      speedFactor = 2;
      config = {
        virtualisation = {
          darwin-builder = {
            memorySize = 8 * 1024;
          };
          cores = 4;
        };
      };
    };
  };
}
