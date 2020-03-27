use Mix.Config

# Configure your database
config :post_tech, PostTech.Repo,
  username: "postgres",
  password: "postgres",
  database: "post_tech_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :post_tech_web, PostTechWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
