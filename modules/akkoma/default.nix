{ config, ... }:

let
  inherit (config.services) akkoma;
  inherit (config.sops) secrets;
in
{
  services = {
    akkoma = {
      enable = true;
      config = {
        ":pleroma" = {
          ":instance" = {
            name = "walkah.social";
            email = "walkah@walkah.net";
            notify_email = "walkah@walkah.net";
            description = "James Walker's personal Akkoma instance";
            registrations_open = false;
            invites_enabled = true;
            federating = true;
            federation_incoming_replies_max_depth = null;
            allow_relay = true;
            safe_dm_mentions = true;
            external_user_synchronization = true;
            cleanup_attachments = true;
          };
          ":media_proxy" = {
            enabled = false;
            redirect_on_failure = true;
          };
          "Pleroma.Web.Endpoint" = {
            secret_key_base = { _secret = secrets.akkoma-secret-key-base.path; };
            signing_salt = { _secret = secrets.akkoma-signing-salt.path; };
            live_view.signing_salt = { _secret = secrets.akkoma-signing-salt.path; };
            url = {
              host = "walkah.social";
              scheme = "https";
              port = 443;
            };
            http = {
              ip = "127.0.0.1";
              port = 4000;
            };
          };
        };
        ":web_push_encryption" = {
          ":vapid_details" = {
            private_key = { _secret = secrets.akkoma-vapid-private-key.path; };
            public_key = { _secret = secrets.akkoma-vapid-public-key.path; };
          };
        };
        ":joken" = {
          ":default_signer" = { _secret = secrets.akkoma-joken-signer.path; };
        };
      };
      nginx = null; # doing this manually
    };

    postgresql = {
      enable = true;
    };

    postgresqlBackup = {
      enable = true;
      databases = [ "akkoma" ];
    };
  };

  sops.secrets.akkoma-secret-key-base = {
    owner = akkoma.user;
  };

  sops.secrets.akkoma-signing-salt = {
    owner = akkoma.user;
  };

  sops.secrets.akkoma-vapid-private-key = {
    owner = akkoma.user;
  };

  sops.secrets.akkoma-vapid-public-key = {
    owner = akkoma.user;
  };

  sops.secrets.akkoma-joken-signer = {
    owner = akkoma.user;
  };
}
