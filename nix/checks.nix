{
  system,
  pre-commit-hooks,
  ...
}:
{
  pre-commit-check = pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      deadnix.enable = true;
      nixfmt-rfc-style.enable = true;
      statix.enable = true;
    };
  };
}
