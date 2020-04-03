defmodule PostTech.Accounts.UserContacts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_contacts" do
    field :type, :string
    field :url, :string

    belongs_to :user_detail, PostTech.Accounts.UserDetail
  end

  @doc false
  def changeset(user_contacts, attrs) do
    user_contacts
    |> cast(attrs, [:type, :url, :user_detail_id])
    |> validate_required([:type, :url, :user_detail_id])
  end
end
