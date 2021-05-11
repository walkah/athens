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
        prometheus 0.0.0.0:9153
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
