defmodule LevyApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    has_many :votes, Vote
    has_many :comments, Comments
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
