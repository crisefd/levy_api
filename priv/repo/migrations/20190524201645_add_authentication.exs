defmodule LevyApi.Repo.Migrations.AddAuthentication do
  use Ecto.Migration

  def change do
    alter table(:users) do
     add :email, :string, unique: true
     add :encrypted_password, :string 
    end
  end
end
