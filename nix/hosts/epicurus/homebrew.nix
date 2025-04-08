_:

{
  homebrew = {
    taps = [
      "homebrew/cask"
      "homebrew/services"
    ];

    brews = [
      "btop"
      "code-server"
      "coreutils"
      "mosh"
    ];

    casks = [
      "1password"
      "docker"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "gpg-suite"
      "plex-media-server"
      "stats"
      "synology-drive"
      "tailscale"
    ];

    # TODO: re-enable when https://github.com/nix-darwin/nix-darwin/issues/1323 is resolved
    # masApps = {
    # Xcode = 497799835;
    # };
  };
}
