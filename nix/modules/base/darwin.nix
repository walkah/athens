{ ... }:
{

  imports = [
    ./common.nix
    ../../users
  ];

  nix = {
    enable = true;

    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

    gc = {
      interval = {
        Hour = 3;
        Minute = 16;
        Weekday = 6;
      };
      options = "--delete-older-than 30d";
    };

    linux-builder = {
      enable = true;
      maxJobs = 4;
      config = {
        virtualisation = {
          darwin-builder = {
            diskSize = 40 * 1024;
            memorySize = 8 * 1024;
          };
          cores = 6;
        };
      };
    };

    settings = {
      trusted-users = [
        "root"
        "@admin"
      ];
    };
  };

  environment.etc = {
    "sudoers.d/walkah".text = ''
      walkah   ALL = (ALL) NOPASSWD: ALL
    '';
  };

  homebrew = {
    enable = true;
    prefix = "/opt/homebrew";
    global = {
      brewfile = true;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "none";
      upgrade = true;
    };
  };

  system = {
    primaryUser = "walkah";
    stateVersion = 4;
  };
}
