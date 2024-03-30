{ self, nixpkgs, deploy-rs, ... }:
let
  mkDeploy = hostName:
    let
      inherit (self.hosts.${hostName}) type address system sshUser;
      pkgs = import nixpkgs { inherit system; };
      deployPkgs = import nixpkgs {
        inherit system;
        overlays = [
          deploy-rs.overlays.default
          (_self: super: {
            deploy-rs = {
              inherit (pkgs) deploy-rs; inherit (super.deploy-rs) lib;
            };
          })
        ];
      };
      inherit (deployPkgs.deploy-rs.lib) activate;
    in
    {
      hostname = address;
      profiles.system = {
        user = "root";
        inherit sshUser;
        path = activate.${type} self."${type}Configurations".${hostName};
      };
    };
in
{
  nodes = {
    socrates = mkDeploy "socrates";
    plato = mkDeploy "plato";
    agent = mkDeploy "agent";
    form = mkDeploy "form";
    matter = mkDeploy "matter";
    purpose = mkDeploy "purpose";
    epicurus = mkDeploy "epicurus";
  };
}
