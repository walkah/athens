{ lib, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      chezmoi
      direnv
      eza
      fzf
      git
      htop
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
