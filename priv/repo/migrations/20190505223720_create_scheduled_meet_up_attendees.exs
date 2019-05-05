defmodule LevyApi.Repo.Migrations.CreateScheduledMeetUpAttendees do
  use Ecto.Migration

  def change do
    create table(:scheduled_meet_up_attendees) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :scheduled_meet_up_id, references(:scheduled_meet_ups, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:scheduled_meet_up_attendees, [:user_id, :scheduled_meet_up_id])
  end
end
