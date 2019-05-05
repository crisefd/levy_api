defmodule LevyApi.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :name, :string
      add :isbn, :string
      add :author, :string
      add :book_club_id, references(:book_clubs, on_delete: :delete_all )

      timestamps()
    end

  end
end
