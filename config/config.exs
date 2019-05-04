# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :levy_api,
  ecto_repos: [LevyApi.Repo]

# Configures the endpoint
config :levy_api, LevyApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gSNzulEKXlW4GlvoqM0lCtAcYL3rhlYx18nJWfRle22kBI9FgdyxMvhBIdn5EB7F",
  render_errors: [view: LevyApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LevyApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
