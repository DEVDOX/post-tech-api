defmodule PostTech.Contents.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  schema "tags" do
    field :name, :string
    field :url_name, :string

    belongs_to :user_detail, PostTech.Accounts.UserDetail

    many_to_many :posts,  PostTech.Contents.Post, join_through: "posts_tags"

    timestamps()
  end

  @doc false
  def changeset(tags, attrs) do
    tags
    |> cast(attrs, [:name, :url_name, :user_detail_id])
    |> validate_required([:name, :url_name, :user_detail_id])
    |> unique_constraint(:name, name: :tags_name_url_name_index)
    |> unique_constraint(:url_name, name: :tags_name_url_name_index)
  end
end
