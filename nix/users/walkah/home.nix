{ lib, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      chezmoi
      bat
      direnv
      eza
      fd
      fzf
      git
      htop
      jq
      starship
      tmux
    ];

    activation.chezmoi = lib.hm.dag.entryAfter [ "installPackages" ] ''
      export PATH="${pkgs.git}/bin:${pkgs.openssh}/bin:$PATH"
      if [ ! -d $HOME/.local/share/chezmoi ]; then
        $DRY_RUN_CMD ${pkgs.chezmoi}/bin/chezmoi init --apply walkah/dotfiles
      else
        $DRY_RUN_CMD ${pkgs.chezmoi}/bin/chezmoi update --apply
      fi
    '';

    stateVersion = "24.05";
  };
}
