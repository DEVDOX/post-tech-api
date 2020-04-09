defmodule PostTech.Repo.Migrations.CreatePostLikes do
  use Ecto.Migration

  def change do
    create table(:post_likes) do
      add :post_id, references(:posts, on_delete: :nothing)
      add :user_detail_id, references(:user_details, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:post_likes, [:user_detail_id, :post_id], name: :post_likes_id)
  end
end
