# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :post_tech,
  ecto_repos: [PostTech.Repo]

config :post_tech_web,
  ecto_repos: [PostTech.Repo],
  generators: [context_app: :post_tech]

# Configures the endpoint
config :post_tech_web, PostTechWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D7dF90Efhl0LoxM0iZjJCjXxuKQcEPoHoLy1FIkwDdzV3OHQyQdx/Bx4KbkSn/5i",
  render_errors: [view: PostTechWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PostTechWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "sYsBstfi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :filter_parameters, ["strategy_token", "strategyToken", "token", "secret"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
