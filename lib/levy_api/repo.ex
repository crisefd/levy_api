defmodule LevyApi.Repo do
  use Ecto.Repo,
    otp_app: :levy_api,
    adapter: Ecto.Adapters.Postgres
end
