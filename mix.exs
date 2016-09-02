defmodule Opencast.Mixfile do
  use Mix.Project

  def project do
    [app: :opencast,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test]]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Opencast, []},
      applications: [
        :phoenix,
        :phoenix_pubsub,
        :cowboy,
        :logger,
        :gettext,
        :phoenix_ecto,
        :postgrex,
        :ja_serializer,
        :ex_machina,
        :redix
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.2.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0-rc"},
      {:postgrex, ">= 0.11.1"},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      {:ja_serializer, "~> 0.11.0"},
      {:ex_machina, "~> 1.0.2"},
      {:sweet_xml, "~> 0.5.0"},
      {:excoveralls, "~> 0.4", only: :test},
      {:scrivener, "~> 2.0"},
      {:scrivener_ecto, "~> 1.0"},
      {:redix, "~> 0.4.0"}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
