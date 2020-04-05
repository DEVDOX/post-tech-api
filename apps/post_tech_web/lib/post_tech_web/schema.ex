defmodule PostTechWeb.Schema do
  use Absinthe.Schema

  alias PostTechWeb.Resolvers
  alias PostTechWeb.Data

  import AbsintheErrorPayload.Payload

  import_types Absinthe.Type.Custom
  import_types PostTechWeb.Schema.Types

  query do
    import_fields :user_detail_queries
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
