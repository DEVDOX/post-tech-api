use Mix.Config

config :post_tech, PostTech.Repo,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: System.get_env("POSTGRES_DB") || "post_tech_dev",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: System.get_env("POOL_SIZE") || 10

config :post_tech_web, PostTechWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

config :arc,
  storage: Arc.Storage.Local

config :post_tech, PostTech.Guardian,
  issuer: "post_tech",
  secret_key: "Secret key. You can use `mix guardian.gen.secret` to get one"
