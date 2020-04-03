defmodule PostTech.Repo.Migrations.CreateUserContacts do
  use Ecto.Migration

  def change do
    create table(:user_contacts) do
      add :type, :string
      add :url, :string
      add :user_detail_id, references(:user_details, on_delete: :nothing)
    end

    create index(:user_contacts, [:user_detail_id])
  end
end
