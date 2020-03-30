defmodule PostTechWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :post_tech_web,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PostTechWeb.Application, []},
      extra_applications: [:logger, :runtime_tools, :oauth2]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.16"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:gettext, "~> 0.11"},
      {:post_tech, in_umbrella: true},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:cors_plug, "~> 2.0"},
      {:elixir_uuid, "~> 1.2"},
      {:absinthe, "~> 1.4.0"},
      {:absinthe_plug, "~> 1.4.0"},
      {:dataloader, "~> 1.0.0"},
      {:oauth2, "~> 2.0"},
      {:absinthe_error_payload, "~> 1.0"},
      {:tesla, "~> 1.3.0"},
      {:paginator, git: "https://github.com/qwexvf/paginator"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, we extend the test task to create and migrate the database.
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [test: ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
