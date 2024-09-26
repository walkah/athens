
resource "digitalocean_droplet" "socrates" {
  name       = "socrates"
  image      = "72067660"
  size       = "s-8vcpu-16gb"
  backups    = true
  ipv6       = true
  monitoring = true
}
