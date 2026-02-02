{ ... }:
{
  imports = [
    ./homebrew.nix

    ../../nix/modules/base/darwin.nix
    ../../nix/modules/dev
    ../../nix/modules/builder
  ];

  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "left";
      };
    };
  };
}
