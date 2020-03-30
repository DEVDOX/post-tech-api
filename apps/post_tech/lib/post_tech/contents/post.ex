defmodule PostTech.Contents.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :title, :string
    field :url, :string
    field :uuid, :string

    belongs_to :user, PostTech.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:url, :uuid, :title, :body, :user_id])
    |> PostTech.Utils.check_uuid()
    |> PostTech.Utils.generate_url()
    |> unique_constraint(:uuid)
    |> validate_required([:url, :uuid, :title, :body, :user_id])
  end
end
