defmodule PostTech.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :url, :string
      add :uuid, :string
      add :title, :string
      add :body, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:user_id])
    create unique_index(:posts, [:uuid])
  end
end
