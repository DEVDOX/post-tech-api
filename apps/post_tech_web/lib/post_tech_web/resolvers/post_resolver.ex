defmodule PostTechWeb.Resolvers.PostResolver do
  alias PostTech.Contents

  def list(_, _context, _) do
    {:ok, Contents.list_posts()}
  end

  def show(_, %{url: url}, _) do
    {:ok, Contents.get_post_by_url!(url)}
  end

  def create_post(_, %{params: params}, %{context: %{current_user: current_user}}) do
    case Contents.create_post(params, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} -> 
        {:ok, changeset}
    end
  end
end
