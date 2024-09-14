{ lib, pkgs, ... }: {
  home = {
    username = "walkah";
    # homeDirectory = if pkgs.stdenv.isDarwin then "/Users/walkah" else "/home/walkah";

    packages = with pkgs; [
      chezmoi
      direnv
      eza
      fzf
      git
      starship
      tmux
    ];

    activation.chezmoi = lib.hm.dag.entryAfter [ "installPackages" ] ''
      $DRY_RUN_CMD ${pkgs.chezmoi}/bin/chezmoi init --apply walkah/dotfiles
    '';

    stateVersion = "24.05";
  };
}
