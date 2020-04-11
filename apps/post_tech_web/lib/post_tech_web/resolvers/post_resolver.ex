defmodule PostTechWeb.Resolvers.PostResolver do
  alias PostTech.Contents

  def list(_, _context, _) do
    {:ok, Contents.list_posts()}
  end

  def get_post(_, %{url: url}, %{context: %{current_user: current_user}}) do
    {:ok, Contents.get_post_by(%{url: url}, current_user)}
  end

  def get_like(_, %{url: url}, %{context: %{current_user: current_user}}) do
    {:ok, Contents.get_like(%{url: url}, current_user)}
  end

  def get_post(_, %{url: url}, _) do
    {:ok, Contents.get_post_by(%{url: url})}
  end

  def search_tags(_, params, _) do
    {:ok, Contents.search_tags(params)}
  end

  def get_post(_, %{id: id}, _) do
    {:ok, Contents.get_post_by(%{id: id})}
  end

  def get_user_posts(_, params, _) do
    IO.inspect params
    {:ok, Contents.get_user_posts(params)}
  end

  def get_public_posts(_, params, _) do
    {:ok, Contents.get_public_posts(params)}
  end

  def get_posts_by_tag(_, %{url: url, metadata: metadata} = params, _) do
    {:ok, Contents.get_posts_by_tag(params)}
  end

  def get_user_liked_posts(_, %{unique_name: _unique_name,
    metadata: _metadata} = params, _)
  do
    {:ok, Contents.get_user_liked_posts(params)}
  end

  def create_post(_, %{params: params}, %{context: %{current_user: current_user}}) do
    case Contents.create_post(params, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:ok, changeset}
    end
  end

  def create_like(_, %{url: url}, %{context: %{current_user: current_user}}) do
    IO.inspect current_user
    case Contents.like_post(url, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:ok, changeset}
    end
  end

  def delete_like(_, %{url: url} = params, %{context: %{current_user: current_user}}) do
    case Contents.delete_like(url, current_user) do
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

  def delete_post(_, %{url: url}, %{context: %{current_user: current_user}}) do
    case Contents.delete_post(url, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:ok, changeset}
    end
  end
end
