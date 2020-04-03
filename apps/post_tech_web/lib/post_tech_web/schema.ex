defmodule PostTechWeb.Schema do
  use Absinthe.Schema

  alias PostTechWeb.Resolvers
  alias PostTechWeb.Data

  import AbsintheErrorPayload.Payload

  import_types Absinthe.Type.Custom
  import_types PostTechWeb.Schema.Types

  query do
    @desc "Get a page(list) of user details"
    field :get_user_detail_list, list_of(:user_detail_type) do
      arg :after, :string
      arg :before, :string
      arg :limit, :string
      resolve &Resolvers.UserDetailResolver.list/3
    end

    @desc "Get a detail of a specific user"
    field :get_user_detail, :user_detail_type do
      arg :strategy_id, :string
      arg :strategy, :string
      resolve &Resolvers.UserDetailResolver.show/3
    end

    @desc "Get a detail of a specific user by unique_name"
    field :get_user_detail_by_u_name, :user_detail_type do
      arg :unique_name, :string
      resolve &Resolvers.UserDetailResolver.show/3
    end

    import_fields :post_queries
  end

  mutation do
    import_fields :user_mutations
    import_fields :session_mutations
    import_fields :post_mutations
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Data, Data.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, _object) do
    [] ++ middleware
  end
end
