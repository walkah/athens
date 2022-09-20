import Config

config :pleroma, Pleroma.Web.Endpoint,
  url: [host: "walkah.social", scheme: "https", port: 443],
  http: [ip: {0, 0, 0, 0}, port: 4000]

config :pleroma, :instance,
  name: "walkah.social",
  email: "walkah@walkah.net",
  notify_email: "walkah@walkah.net",
  limit: 5000,
  registrations_open: false

config :pleroma, :media_proxy,
  enabled: false,
  redirect_on_failure: true

config :pleroma, Pleroma.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "pleroma",
  database: "pleroma",
  hostname: "localhost"

# Configure web push notifications
config :web_push_encryption, :vapid_details, subject: "mailto:walkah@walkah.net"

config :pleroma, :database, rum_enabled: false
config :pleroma, :instance, static_dir: "/var/lib/pleroma/static"
config :pleroma, Pleroma.Uploaders.Local, uploads: "/var/lib/pleroma/uploads"
config :pleroma, configurable_from_database: false

config :pleroma, :frontend_configurations,
  pleroma_fe: %{
    alwaysShowSubjectInput: true,
    background: "",
    collapseMessageWithSubject: false,
    disableChat: false,
    greentext: false,
    hideFilteredStatuses: false,
    hideMutedPosts: false,
    hidePostStats: false,
    hideSitename: false,
    hideUserStats: false,
    loginMethod: "password",
    logo: "/static/logo.svg",
    logoMargin: ".1em",
    logoMask: true,
    minimalScopesMode: false,
    noAttachmentLinks: false,
    nsfwCensorImage: "",
    postContentType: "text/plain",
    redirectRootLogin: "/main/friends",
    redirectRootNoLogin: "/walkah",
    scopeCopy: true,
    sidebarRight: true,
    showFeaturesPanel: false,
    showInstanceSpecificPanel: false,
    subjectLineBehavior: "email",
    theme: "pleroma-dark",
    webPushNotifications: false
  }
