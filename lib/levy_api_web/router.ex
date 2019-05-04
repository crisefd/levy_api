defmodule LevyApiWeb.Router do
  use LevyApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LevyApiWeb do
    pipe_through :api
  end

  pipeline :browser do
    plug :accepts, ["html"] 
  end

  scope "/", LevyApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

end
