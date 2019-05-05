defmodule LevyApi.Repo.Migrations.CreateBookClubs do
  use Ecto.Migration

  def change do
    create table(:book_clubs) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
