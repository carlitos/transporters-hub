defmodule TransportersHubWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :transporters_hub,
    module: TransportersHubWeb.Auth.Guardian,
    error_handler: TransportersHubWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource

end
