defmodule PostTech.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  schema "users" do
    field :email, :string
    field :qiita_id, :string
    field :github_id, :string
    field :twitter_id, :string
    field :tos, :boolean, default: false

    field :strategy, :string, virtual: true
    field :strategy_id, :string, virtual: true

    has_one :user_detail, PostTech.Accounts.UserDetail

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :github_id, :twitter_id, :qiita_id, :tos, :strategy, :strategy_id])
    |> validate_required([:email, :tos])
    |> unique_constraint(:email)
    |> unique_constraint(:github_id, name: :users_github_id_index)
    |> unique_constraint(:twitter_id)
    |> unique_constraint(:qiita_id)
    |> set_strategy_id()
  end

  def set_strategy_id(changeset) do
    strategy_id = Ecto.Changeset.get_field(changeset, :strategy_id)
    strategy = Ecto.Changeset.get_field(changeset, :strategy)
    IO.inspect strategy

    change =
      cond do
        strategy == "github" ->
          %{github_id: strategy_id}
        strategy == "qiita" ->
          %{qiita_id: strategy_id}
        strategy == "twitter" ->
          %{twitter_id: strategy_id}
      end

    change(changeset, change)
  end
end
