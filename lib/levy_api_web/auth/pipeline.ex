
defmodule LevyApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :levy_api,
    module: LevyApiWeb.Auth.Guardian,
    error_handler: LevyApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
