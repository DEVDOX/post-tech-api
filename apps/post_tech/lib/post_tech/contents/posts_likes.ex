defmodule PostTech.Contents.PostLikes do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  schema "post_likes" do
    belongs_to :user_detail, PostTech.Contents.UserDetail
    belongs_to :post, PostTech.Contents.Post

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:post_id, :user_detail_id])
    |> unique_constraint(:post_id)
    |> unique_constraint(:user_detail_id)
  end
end
