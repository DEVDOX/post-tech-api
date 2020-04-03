defmodule PostTech.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :url_name, :string
      add :user_detail_id, references(:user_details, on_delete: :nothing)

      timestamps()
    end

    create index(:tags, [:user_detail_id])
    create unique_index(:tags, :name)
    create unique_index(:tags, :url_name)
  end
end
