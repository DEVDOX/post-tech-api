defmodule PostTech.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :tos, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :encrypted_password, :tos])
    |> validate_required([:email, :encrypted_password, :tos])
  end
end
