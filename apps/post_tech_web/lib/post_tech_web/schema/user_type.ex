defmodule PostTechWeb.Schema.UserType do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :user_type do
    field :id, :id
    field :strategy, :string
    field :github_id, :string
    field :twitter_id, :string
    field :qiita_id, :string
  end
end
