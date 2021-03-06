defmodule LevyApiWeb.Router do
  use LevyApiWeb, :router

  @environment  Application.get_env(:levy_api, :environment)

  pipeline :v1 do
    plug CORSPlug
    plug :accepts, ["json"]
    plug LevyApiWeb.Version, version: :v1
  end

  # pipeline :v2 do
  #   plug :accepts, ["json"]
  #   plug LevyApiWeb.Version, version: :v2
  # end

  pipeline :auth do
    if @environment !== :test do
      plug LevyApiWeb.Auth.Pipeline
    end
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", LevyApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

  scope "/v1", LevyApiWeb do
    pipe_through [:v1, :auth]
    resources "/users", UserController
    options "/users", UserController, :options
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

  scope "/v1", LevyApiWeb do
    pipe_through :v1
    post "/users/signup", UserController, :create
    options "/users/signup", UserController, :options
    post "/users/signin", UserController, :signin
    options "/users/signin", UserController, :options
  end

end
