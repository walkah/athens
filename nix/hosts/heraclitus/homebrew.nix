_:

{
  homebrew = {
    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/services"
      "walkah/tap"
      "1password/tap"
      "d12frosted/emacs-plus"
      "heroku/brew"
    ];

    brews = [
      {
        name = "emacs-plus";
        args = [ "with-native-comp" ];
      }
      "awscli"
      "cmake"
      "coreutils"
      "drone-cli"
      "doppler"
      "fontconfig"
      "gcc"
      "gh"
      "helm"
      "heroku"
      "ipfs"
      "kind"
      "kubernetes-cli"
      "libtool"
      "mr"
      "ripgrep"
      "tea"
      "watchman"
    ];

    casks = [
      "1password"
      "1password-cli"
      "android-studio"
      "balenaetcher"
      "beeper"
      "brave-browser"
      "bunch"
      "calibre"
      "cursor"
      "discord"
      "docker"
      "element"
      "fantastical"
      "figma"
      "firefox@developer-edition"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "google-chrome"
      "google-cloud-sdk"
      "gpg-suite"
      "hazel"
      "iterm2"
      "jordanbaird-ice"
      "logi-options+"
      "logitech-camera-settings"
      "microsoft-edge"
      "microsoft-office"
      "minecraft"
      "obsidian"
      "opal-composer"
      "plexamp"
      "raycast"
      "slack"
      "sonos"
      "spotify"
      "stats"
      "steam"
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
      HomeAssistant = 1099568401;
      Tailscale = 1475387142;
      Xcode = 497799835;
    };
  };
}
