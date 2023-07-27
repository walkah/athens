{ self, deploy-rs, ... }:
let
  mkDeploy = hostName:
    let
      inherit (self.hosts.${hostName}) type address system sshUser;
      inherit (deploy-rs.lib.${system}) activate;
    in
    {
      hostname = address;
      profiles.system.user = "root";
      profiles.system.sshUser = sshUser;
      profiles.system.path = activate.${type} self."${type}Configurations".${hostName};
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
