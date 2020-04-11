defmodule PostTech.Contents.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  schema "posts" do
    field :body, :string
    field :title, :string
    field :url, :string
    field :uuid, :string
    field :state, PostTech.Contents.PostState.PostStateEnum

    belongs_to :user_detail, PostTech.Accounts.UserDetail
    # has_one :user_detail, PostTech.Accounts.UserDetail, references: :user_id, foreign_key: :user_id

    many_to_many :tags,  PostTech.Contents.Tag, join_through: "posts_tags", on_replace: :delete
    has_many :likes,  PostTech.Contents.PostLikes

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:url, :uuid, :title, :body, :user_detail_id, :state])
    |> PostTech.Utils.check_uuid()
    |> PostTech.Utils.generate_url()
    |> unique_constraint(:uuid)
    |> validate_required([:url, :uuid, :title, :body, :user_detail_id, :state])
  end
end
