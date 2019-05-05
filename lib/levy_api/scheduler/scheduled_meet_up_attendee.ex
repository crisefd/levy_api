defmodule LevyApi.Scheduler.ScheduledMeetUpAttendee do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:user_id, :scheduled_meet_up_id]

  schema "scheduled_meet_up_attendees" do
    field :user_id, :id
    field :scheduled_meet_up_id, :id
    belongs_to :user_ids, User
    belongs_to :scheduled_meet_ups, ScheduledMeetUp
    timestamps()
  end

  @doc false
  def changeset(scheduled_meet_up_attendee, attrs) do
    scheduled_meet_up_attendee
    |> cast(attrs, [])
    |> validate_required( @required_fields)
  end
end
