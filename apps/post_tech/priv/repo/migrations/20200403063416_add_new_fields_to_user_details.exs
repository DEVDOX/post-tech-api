defmodule PostTech.Repo.Migrations.AddNewFieldsToUserDetails do
  use Ecto.Migration

  def up do
    alter table(:user_details) do
      add :tagline, :text
      add :website_url, :string
      add :locale_code, :string
    end
  end

  def down do
    alter table(:user_details) do
      remove :tagline
      remove :website_url
      remove :locale_code
    end
  end
end
