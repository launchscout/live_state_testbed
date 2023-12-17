defmodule LivestateTestbed.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string

      timestamps()
    end
  end
end
