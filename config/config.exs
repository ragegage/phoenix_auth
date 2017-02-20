# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :login_app,
  ecto_repos: [LoginApp.Repo]

# Configures the endpoint
config :login_app, LoginApp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NMXbV7kwkMF6JZ5m5bdQB6N86NkQyHuUNSYGH5qKRtirmjqQZdk7tN5RYqm5Hd0O",
  render_errors: [view: LoginApp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LoginApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :guardian, Guardian,
  issuer: "LoginApp.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: LoginApp.GuardianSerializer,
  secret_key: to_string(Mix.env) <> "SuPeRsEcReT"