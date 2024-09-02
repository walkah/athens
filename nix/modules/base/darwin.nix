{ pkgs, dotfiles, ... }: {

  imports = [ ./common.nix ];

  nix = {
    configureBuildUsers = true;

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
    settings = {
      trusted-users = [ "root" "@admin" ];
    };
  };

  environment.etc = {
    "sudoers.d/walkah".text = ''
      walkah   ALL = (ALL) NOPASSWD: ALL
    '';
  };

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    global = {
      brewfile = true;
      lockfiles = false;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.walkah = import "${dotfiles}/home.nix";
  };

  users.users.walkah = {
    home = "/Users/walkah";
    shell = pkgs.zsh;
  };

  system.stateVersion = 4;
}
