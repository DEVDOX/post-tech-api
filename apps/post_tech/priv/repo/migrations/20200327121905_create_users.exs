defmodule PostTech.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :encrypted_password, :string
      add :tos, :boolean, default: false, null: false

      timestamps()
    end

  end
end
