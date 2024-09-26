terraform {
  required_version = ">= 1.8.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
module "digitalocean" {
  source   = "./terraform/digitalocean"
  do_token = var.do_token
}

