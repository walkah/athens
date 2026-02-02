{ ... }:
{
  imports = [
    ./homebrew.nix

    ../../nix/modules/base/darwin.nix
    ../../nix/modules/builder
    ../../nix/modules/dev
  ];
}
