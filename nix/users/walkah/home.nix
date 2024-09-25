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
      export PATH="${pkgs.git}/bin:$PATH"
      $DRY_RUN_CMD ${pkgs.chezmoi}/bin/chezmoi init --apply walkah/dotfiles
    '';

    stateVersion = "24.05";
  };
}
