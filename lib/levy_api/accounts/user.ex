defmodule LevyApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias LevyApi.BookFeedBack.Vote
  alias LevyApi.BookFeedBack.Comment
  alias LevyApi.Scheduler.ScheduledMeetUpAttendee


  @required_fields [:username, :password ]

  schema "users" do
    field :username, :string
    field :name, :string
    field :surname, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    has_many :votes, Vote
    has_many :comments, Comment
    has_many :scheduled_meet_up_attendees, ScheduledMeetUpAttendee
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:password, min: 10)
    |> unique_constraint(:email)
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
          changeset
    end
  end
 

end
