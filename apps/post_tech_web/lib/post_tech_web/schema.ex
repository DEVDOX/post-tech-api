defmodule PostTechWeb.Schema do
  alias PostTechWeb.Resolvers
  alias PostTechWeb.Data

  import_types Absinthe.Type.Custom
  import_types PostTechWeb.Schema.Types


  query do
  end

  mutation do
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
