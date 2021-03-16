{ config, lib, pkgs, ... }:

{
  services.coredns = {
    enable = true;
    config = ''
      . {
        log
        errors
        cache
        dnssec
        forward . tls://1.1.1.1 tls://1.0.0.1 {
          tls_servername cloudflare-dns.com
        }
      }

      walkah.lab {
        file ${./walkah.lab.zone}
      }
    '';
  };
}
