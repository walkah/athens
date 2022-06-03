{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    autoUpdate = true;
    cleanup = "zap";
    global = {
      brewfile = true;
      noLock = true;
    };

    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/services"
    ];

    brews = [ "coreutils" ];

    casks = [
      "1password"
      "bartender"
      "brave-browser"
      "bunch"
      "discord"
      "docker"
      "element"
      "fantastical"
      "figma"
      "firefox"
      "firefox-developer-edition"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "google-chrome"
      "gpg-suite"
      "hazel"
      "home-assistant"
      "ipfs"
      "iterm2"
      "keybase"
      "logi-options-plus"
      "logseq"
      "raycast"
      "slack"
      "sonos"
      "spotify"
      "stats"
      "syncthing"
      "synology-drive"
      "todoist"
      "visual-studio-code"
      "zoom"
    ];

    masApps = {
      OnePasswordSafari = 1569813296;
      Bumpr = 1166066070;
      DayOne = 1055511498;
      Drafts = 1435957248;
      Reeder = 1529448980;
      Tailscale = 1475387142;
      UlyssesMac = 1225570693;
      Xcode = 497799835;
    };
  };
}
