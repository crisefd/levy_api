defmodule LevyApi.Scheduler.ScheduledMeetUp do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fiels [:where, :name, :book_id]

  schema "scheduled_meet_ups" do
    field :name, :string
    field :where, :string
    field :book_id, :id
    belongs_to :books, Book
    has_many :scheduled_meet_up_attendees, ScheduledMeetUpAttendee
    timestamps()
  end

  @doc false
  def changeset(scheduled_meet_up, attrs) do
    scheduled_meet_up
    |> cast(attrs, [])
    |> validate_required(@required_fiels)
  end
end
