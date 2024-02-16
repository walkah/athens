_:

{
  homebrew = {
    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/services"
      "fission-codes/fission"
    ];

    brews = [ "code-server" "coreutils" "homestar" "mosh" ];

    casks = [
      "1password"
      "docker"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "gpg-suite"
      "plex-media-server"
      "stats"
      "synology-drive"
    ];

    masApps = {
      Tailscale = 1475387142;
      Xcode = 497799835;
    };
  };
}
