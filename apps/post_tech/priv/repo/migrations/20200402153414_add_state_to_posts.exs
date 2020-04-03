defmodule PostTech.Repo.Migrations.AddStateToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :is_public
      remove :is_draft

      add :state, :string
    end
  end
end
