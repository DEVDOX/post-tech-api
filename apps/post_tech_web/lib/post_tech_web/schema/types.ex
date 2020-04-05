defmodule PostTechWeb.Schema.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias PostTechWeb.Schema.{UserType, UserDetailType, PostType, SessionType}

  object :metadata_type do
    field :after, :string
    field :before, :string
    field :limit, :integer
    field :total_count, :integer
    field :total_count_cap_exceeded, :boolean
  end

  import_types(UserType)
  import_types(UserDetailType)
  import_types(PostType)
  import_types(SessionType)
end

