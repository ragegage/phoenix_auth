defmodule LoginApp.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    drop table(:users)

    create table(:users) do
      add :email, :string, null: false
      add :password_digest, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
