import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :soulerl, SoulerlWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "tGeMwc5KE3IrnvNj2qreyw3Mbv3qIoIwW5beLuPkv3/A4E4XRUweieVo1w9xrmNO",
  server: false

# In test we don't send emails.
config :soulerl, Soulerl.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
