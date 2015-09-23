# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :phoenix_diff, PhoenixDiff.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "T3BfGCM1iUDyJ5GubCiPTlOAZ8vPVstk0nt6xxQeCeC4OL26je+iO88nRkP3HdbF",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: PhoenixDiff.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :phoenix_diff, :generated_path, "generated/"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
