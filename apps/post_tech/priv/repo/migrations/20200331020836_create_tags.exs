defmodule PostTech.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :body, :string

      timestamps()
    end

  end
end
