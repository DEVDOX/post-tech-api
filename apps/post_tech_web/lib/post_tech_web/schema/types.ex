defmodule PostTechWeb.Schema.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias PostTechWeb.Schema.{UserType, UserDetailType, PostType, SessionType}

  import_types(UserType)
  import_types(UserDetailType)
  import_types(PostType)
  import_types(SessionType)
end

