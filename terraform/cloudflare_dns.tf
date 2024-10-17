locals {
  account_id = "273a4698f673c012fd50161e46ceafdb"
}

resource "cloudflare_zone" "walkah_codes" {
  account_id = local.account_id
  zone       = "walkah.codes"
}

resource "cloudflare_record" "walkah_codes" {
  zone_id = cloudflare_zone.walkah_codes.id
  name    = "walkah.codes"
  type    = "A"
  proxied = true
  content = digitalocean_droplet.socrates.ipv4_address
}

