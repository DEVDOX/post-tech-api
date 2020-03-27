defmodule PostTechWeb.Router do
  use PostTechWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug PostTechWeb.Plugs.Context
  end


  scope "/api" do
    pipe_through [:api]

    forward "/graphql", Absinthe.Plug, schema: TeamRecruitWeb.Schema

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL, schema: TeamRecruitWeb.Schema
    end
  end

end
