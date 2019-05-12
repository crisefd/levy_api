defmodule LevyApi.Scheduler.ScheduledMeetUp do
  use Ecto.Schema
  import Ecto.Changeset
  alias LevyApi.Scheduler.ScheduledMeetUpAttendee

  @required_fields [:where, :name]

  schema "scheduled_meet_ups" do
    field :name, :string
    field :where, :string
    belongs_to :book, Book
    has_many :scheduled_meet_up_attendees, ScheduledMeetUpAttendee
    timestamps()
  end

  @doc false
  def changeset(scheduled_meet_up, attrs) do
    scheduled_meet_up
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
