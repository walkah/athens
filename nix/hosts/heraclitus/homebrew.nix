_:

{
  homebrew = {
    taps = [
      "homebrew/cask"
      "homebrew/services"
      "walkah/tap"
      "1password/tap"
      "d12frosted/emacs-plus"
      "dracula/install"
      "heroku/brew"
    ];

    brews = [
      "act"
      "asdf"
      "argocd"
      "cmake"
      "cocoapods"
      "coreutils"
      {
        name = "emacs-plus";
        args = [ "--with-c9rgreen-sonoma-icon" ];
      }
      "fontconfig"
      "gcc"
      "gh"
      "helm"
      "heroku"
      "ipfs"
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
      "actual"
      "android-studio"
      "arc"
      "balenaetcher"
      "beeper"
      "brave-browser"
      "bunch"
      "calibre"
      "claude"
      "discord"
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
      "jordanbaird-ice@beta"
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
      "slack"
      "sonos"
      "spotify"
      "stats"
      "steam"
      "synology-drive"
      "tailscale-app"
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
      Drafts = 1435957248;
      HomeAssistant = 1099568401;
      Xcode = 497799835;
    };
  };
}
