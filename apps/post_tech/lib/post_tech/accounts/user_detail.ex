defmodule PostTech.Accounts.UserDetail do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  schema "user_details" do
    field :bio, :string
    field :company, :string
    field :display_name, :string
    field :location, :string
    field :organization, :string
    field :avatar, :string
    field :unique_name, :string

    field :tagline, :string
    field :website_url, :string
    field :locale_code, :string

    belongs_to :user, PostTech.Accounts.User
    has_many :contacts, PostTech.Accounts.UserContacts

    timestamps()
  end

  @doc false
  def changeset(user_detail, attrs) do
    user_detail
    |> cast(attrs,
      [:display_name,
        :avatar,
        :location,
        :organization,
        :company,
        :bio,
        :unique_name,
        :user_id,
        :tagline,
        :website_url,
        :locale_code])
        |> validate_required([:display_name, :unique_name, :user_id])
  end
end
