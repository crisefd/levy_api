defmodule LevyApiWeb.Router do
  use LevyApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LevyApiWeb do
    pipe_through :api
    resources "/users", UserController
    resources "/book_clubs", BookClubController do
      resources "/books", BookController do
        resources "/comments", CommentController, only: [:create]
        resources "/votes", VoteController, only: [:create]
      end
    end
    resources "/scheduled_meet_ups", ScheduledMeetUp, only: [:create]
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", LevyApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

end
