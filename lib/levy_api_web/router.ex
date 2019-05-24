defmodule LevyApiWeb.Router do
  use LevyApiWeb, :router

  pipeline :v1 do
    plug :accepts, ["json"]
    plug LevyApiWeb.Version, version: :v1
  end

  # pipeline :v2 do
  #   plug :accepts, ["json"]
  #   plug LevyApiWeb.Version, version: :v2
  # end

  scope "/v1", LevyApiWeb do
    pipe_through :v1
    resources "/users", UserController
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
    resources "/book_clubs", BookClubController do
      resources "/books", BookController do
        resources "/comments", CommentController, only: [:create]
        resources "/votes", VoteController, only: [:create]
      end
    end
    resources "/scheduled_meet_ups", ScheduledMeetUpController do
      resources "/scheduled_meet_up_attendees", ScheduledMeetUpAttendeeController, except: [:show, :update]
    end
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", LevyApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

end
