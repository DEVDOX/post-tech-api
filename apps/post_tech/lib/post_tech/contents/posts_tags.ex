defmodule PostTech.Contents.PostsTags do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  schema "posts_tags" do
    belongs_to :tag, PostTech.Contents.Tag, primary_key: :tag_id
    belongs_to :post, PostTech.Contents.Post, primary_key: :post_id
  end

  @doc false
  def changeset(tag_posts, attrs) do
    tag_posts
    |> cast(attrs, [:post_id, :tag_id])
    # |> unique_constraint(:tag_id)
  end
end
