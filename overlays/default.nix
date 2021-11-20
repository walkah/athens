self: super: {
  tailscale = super.callPackage ../pkgs/tailscale/default.nix { };
}
