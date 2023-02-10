import * as digitalocean from "@pulumi/digitalocean";

const socrates = new digitalocean.Droplet("socrates", {
  backups: true,
  image: "72067660",
  ipv6: true,
  monitoring: true,
  name: "socrates",
  privateNetworking: true,
  region: digitalocean.Region.TOR1,
  size: digitalocean.DropletSlug.DropletS8VCPU16GB,
  vpcUuid: "392caea6-dc7f-11e8-b1a9-3cfdfea9ee58",
}, {
  protect: true,
});

export const socratesIP = socrates.ipv4Address;
