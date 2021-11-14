{ config, lib, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
in
{
  imports = [ "${sources.sops-nix}/modules/sops" ];
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
}
