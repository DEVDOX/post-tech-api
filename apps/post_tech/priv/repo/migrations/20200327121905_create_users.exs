defmodule PostTech.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :qiita_id, :string
      add :github_id, :string
      add :twitter_id, :string
      add :tos, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:qiita_id])
    create unique_index(:users, [:github_id])
    create unique_index(:users, [:twitter_id])
  end
end
