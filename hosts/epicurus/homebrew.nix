{ config, lib, pkgs, ... }:

{
  homebrew = {
    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/services"
    ];

    brews = [ "code-server" "coreutils" "mosh" ];

    casks = [
      "1password"
      "alfred"
      "docker"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "gpg-suite"
      "ipfs"
      "keybase"
      "plex-media-server"
      "stats"
      "syncthing"
      "synology-drive"
    ];

    masApps = {
      Bumpr = 1166066070;
      Magnet = 441258766;
      Tailscale = 1475387142;
      Xcode = 497799835;
    };
  };
}
