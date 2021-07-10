{ config, lib, pkgs, ... }:
with lib;

let cfg = config.walkah.coredns;
in {
  options.walkah.coredns = {
    enable = mkEnableOption "";
    addr = mkOption {
      type = types.str;
      default = "0.0.0.0";
      example = "192.168.6.1";
    };
  };

  config = mkIf cfg.enable {
    services.coredns = {
      enable = true;
      config = ''
        . {
          bind ${cfg.addr}
          prometheus ${cfg.addr}:9153
          log
          errors
          cache
          dnssec
          forward . tls://1.1.1.1 tls://1.0.0.1 {
            tls_servername cloudflare-dns.com
          }
        }

        walkah.lab {
          bind ${cfg.addr}
          file ${./walkah.lab.zone}
        }
      '';
    };

    networking = {
      nameservers = [ "100.111.208.75" "100.103.57.96" ];
      search = [ "walkah.lab" ];
    };
  };
}
