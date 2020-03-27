defmodule PostTech.Accounts.UserDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_details" do
    field :bio, :string
    field :company, :string
    field :display_name, :string
    field :location, :string
    field :organization, :string
    field :profile_image_url, :string
    field :unique_name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_detail, attrs) do
    user_detail
    |> cast(attrs, [:display_name, :profile_image_url, :location, :organization, :company, :bio, :unique_name])
    |> validate_required([:display_name, :profile_image_url, :location, :organization, :company, :bio, :unique_name])
  end
end
