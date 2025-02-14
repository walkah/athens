{ ... }:
{
  imports = [
    ./homebrew.nix

    ../../modules/base/darwin.nix
    ../../modules/dev
    ../../modules/builder
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
