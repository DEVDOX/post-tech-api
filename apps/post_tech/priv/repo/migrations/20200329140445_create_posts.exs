defmodule PostTech.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :url, :string
      add :uuid, :string
      add :title, :string
      add :body, :text
      add :is_public, :boolean
      add :is_draft, :boolean
      add :user_detail_id, references(:user_details, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:user_detail_id])
    create unique_index(:posts, [:uuid])
  end
end
