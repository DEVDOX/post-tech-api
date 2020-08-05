use Mix.Config

config :post_tech_web, PostTechWeb.Endpoint,
  http: [port: 4000],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

config :post_tech, PostTech.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

config :logger, level: :info
