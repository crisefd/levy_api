defmodule LevyApi.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
      add :surname, :string
    end
  end
end
