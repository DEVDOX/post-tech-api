defmodule PostTech.Contents.Tags do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :body, :string

    has_many :tag_psots, PostTech.Contents.TagPosts
    has_many :posts, through: [:tag_psots, :post]

    timestamps()
  end

  @doc false
  def changeset(tags, attrs) do
    tags
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
