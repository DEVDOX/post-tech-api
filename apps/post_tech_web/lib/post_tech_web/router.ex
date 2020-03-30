defmodule PostTechWeb.Router do
  use PostTechWeb, :router

  pipeline :graphql_api do
    plug :accepts, ["json"]
    plug PostTechWeb.Plugs.Context
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through [:graphql_api]

    forward "/graphql", Absinthe.Plug, schema: PostTechWeb.Schema

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL, schema: PostTechWeb.Schema
    end

  end

  scope "/api/auth", PostTechWeb do
    pipe_through [:api]

    get "/callback", AuthController, :callback
  end
end
