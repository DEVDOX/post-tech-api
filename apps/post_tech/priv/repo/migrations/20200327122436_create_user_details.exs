defmodule PostTech.Repo.Migrations.CreateUserDetails do
  use Ecto.Migration

  def change do
    create table(:user_details) do
      add :display_name, :string
      add :profile_image_url, :string
      add :location, :string
      add :organization, :string
      add :company, :string
      add :bio, :string
      add :unique_name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_details, [:user_id])
  end
end
