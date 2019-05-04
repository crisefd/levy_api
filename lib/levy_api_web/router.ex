defmodule LevyApiWeb.Router do
  use LevyApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LevyApiWeb do
    pipe_through :api
  end
end
