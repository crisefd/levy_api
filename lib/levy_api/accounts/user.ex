defmodule LevyApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias LevyApi.BookFeedBack.Vote
  alias LevyApi.BookFeedBack.Comment
  alias LevyApi.Scheduler.ScheduledMeetUpAttendee

  schema "users" do
    field :username, :string
    field :name, :string
    field :surname, :string
    has_many :votes, Vote
    has_many :comments, Comment
    has_many :scheduled_meet_up_attendees, ScheduledMeetUpAttendee
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
