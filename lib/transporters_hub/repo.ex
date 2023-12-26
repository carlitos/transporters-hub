defmodule TransportersHub.Repo do
  use Ecto.Repo,
    otp_app: :transporters_hub,
    adapter: Ecto.Adapters.Postgres
end
