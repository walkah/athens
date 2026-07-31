_:

{
  homebrew = {
    taps = [
      "homebrew/cask"
      "homebrew/services"
      {
        name = "1password/tap";
        trusted = true;
      }
      {
        name = "d12frosted/emacs-plus";
        trusted = true;
      }
      {
        name = "dracula/install";
        trusted = true;
      }
    ];

    brews = [
      "act"
      "apfel"
      "asdf"
      "argocd"
      "cmake"
      "cocoapods"
      "coreutils"
      "emacs-plus"
      "fontconfig"
      "gcc"
      "gh"
      "helm"
      "kubo"
      "kind"
      "kubernetes-cli"
      "kustomize"
      "libtool"
      "mas"
      "mr"
      "ollama"
      "opentofu"
      "podman"
      "podman-compose"
      "r"
      "ripgrep"
      "tea"
      "terminal-notifier"
      "watchman"
    ];

    casks = [
      "1password"
      "1password-cli"
      "android-studio"
      "arc"
      "balenaetcher"
      "brave-browser"
      "bunch"
      "calibre"
      "claude"
      "cleanmymac"
      "discord"
      "docker-desktop"
      "dracula-xcode"
      "element"
      "fantastical"
      "figma"
      "firefox@developer-edition"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "ghostty"
      "google-chrome"
      "gpg-suite"
      "hazel"
      "logi-options+"
      "logitech-camera-settings"
      "microsoft-edge"
      "minecraft"
      "obsidian"
      "opal-composer"
      "plexamp"
      "podman-desktop"
      "raycast"
      "rstudio"
      "signal"
      "slack"
      "sonos"
      "stats"
      "steam"
      "synology-drive"
      "tailscale-app"
      "thaw"
      "todoist-app"
      "visual-studio-code"
      "zen"
      "zoom"
      "zulu@17"
    ];

    masApps = {
      OnePasswordSafari = 1569813296;
      Bumpr = 1166066070;
      DayOne = 1055511498;
      Developer = 640199958;
      Drafts = 1435957248;
      GoodNotes = 1444383602;
      HomeAssistant = 1099568401;
      Ivory = 6444602274;
      Mela = 1568924476;
      Parcel = 375589283;
      Reeder = 1529448980;
      TestFlight = 899247664;
      Xcode = 497799835;
    };
  };
}
