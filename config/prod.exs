use Mix.Config

config :post_tech_web, PostTechWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "warm-anchorage-79068.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  server: true

config :post_tech, PostTech.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

config :logger, level: :info
