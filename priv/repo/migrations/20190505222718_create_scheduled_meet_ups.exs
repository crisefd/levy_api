defmodule LevyApi.Repo.Migrations.CreateScheduledMeetUps do
  use Ecto.Migration

  def change do
    create table(:scheduled_meet_ups) do
      add :where, :string
      add :name, :string
      add :book_id, references(:books, on_delete: :delete_all)

      timestamps()
    end

    create index(:scheduled_meet_ups, [:book_id])
  end
end
