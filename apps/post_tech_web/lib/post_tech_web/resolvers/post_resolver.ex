defmodule PostTechWeb.Resolvers.PostResolver do
  alias PostTech.Contents

  def list(_, _context, _) do
    {:ok, Contents.list_posts()}
  end

  def get_post(_, %{url: url}, _) do
    {:ok, Contents.get_post_by(%{url: url})}
  end

  def get_post(_, %{id: id}, _) do
    {:ok, Contents.get_post_by(%{id: id})}
  end

  def get_user_posts(_, params, _) do
    {:ok, Contents.get_user_posts(params)}
  end

  def get_public_posts(_, params, _) do
    {:ok, Contents.get_public_posts(params)}
  end

  def create_post(_, %{params: params}, %{context: %{current_user: current_user}}) do
    case Contents.create_post(params, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} -> 
        {:ok, changeset}
    end
  end

  def create_like(_, %{post_url: post_url}, %{context: %{current_user: current_user}}) do
    case Contents.like_post(post_url, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} -> 
        {:ok, changeset}
    end
  end

  def update_post(_, %{params: params}, %{context: %{current_user: current_user}}) do
    case Contents.update_post(params, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} -> 
        {:ok, changeset}
    end
  end

  def delete_post(_, %{params: params}, %{context: %{current_user: current_user}}) do
    case Contents.delete_post(params, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} -> 
        {:ok, changeset}
    end
  end
end
