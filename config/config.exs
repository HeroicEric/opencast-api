# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :opencast,
  ecto_repos: [Opencast.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :opencast, OpencastWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KxH+RjJ46Xyw8RVE7PHVJIkOdepPoOmLG9MjUyun722BB2vD9Ii5AGTkTkd6lSg7",
  render_errors: [view: OpencastWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Opencast.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :format_encoders, "json-api": Jason

# Configure plug to handle JSON API mime type
config :mime, :types, %{"application/vnd.api+json" => ["json-api"]}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
