{ config, lib, pkgs, ... }:

{
  homebrew = {
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
      "gather"
      "google-chrome"
      "gpg-suite"
      "hazel"
      "ipfs"
      "iterm2"
      "keybase"
      "logi-options-plus"
      "logseq"
      "minecraft"
      "obsidian"
      "plexamp"
      "raycast"
      "slack"
      "sonos"
      "spotify"
      "stats"
      "steam"
      "syncthing"
      "synology-drive"
      "todoist"
      "visual-studio-code"
      "whalebird"
      "zoom"
    ];

    masApps = {
      OnePasswordSafari = 1569813296;
      Bumpr = 1166066070;
      DayOne = 1055511498;
      Drafts = 1435957248;
      HomeAssistant = 1099568401;
      Reeder = 1529448980;
      Tailscale = 1475387142;
      UlyssesMac = 1225570693;
      Xcode = 497799835;
    };
  };
}
