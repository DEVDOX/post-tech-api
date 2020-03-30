defmodule PostTech.Accounts.UserDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_details" do
    field :bio, :string
    field :company, :string
    field :display_name, :string
    field :location, :string
    field :organization, :string
    field :avatar, :string
    field :unique_name, :string

    belongs_to :user, PostTech.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(user_detail, attrs) do
    user_detail
    |> cast(attrs, [:display_name, :avatar, :location, :organization, :company, :bio, :unique_name, :user_id])
    |> validate_required([:display_name, :unique_name, :user_id])
  end
end
