defmodule PostTech.Contents do
  @moduledoc """
  The Contents context.
  """

  import Ecto.Query, warn: false
  alias PostTech.Repo

  alias PostTech.Contents.{Post, Tag, PostLikes}
  alias PostTech.Accounts
  alias PostTech.Accounts.UserDetail

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end


  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  def get_post_by(%{url: url}) do
    Post
    |> where([p], p.state == ^:published)
    |> where([p], p.url == ^url)
    |> preload([p], [:user_detail, :tags, :likes])
    |> Repo.one()
  end

  def get_post_by(%{post_url: post_url, like_id: like_id}) do
    Post
    |> join(:left, [p], like in assoc(p, :likes), on: like.id == ^like_id)
    |> where([p, like], p.url == ^post_url)
    |> preload([p], [:likes])
    |> Repo.one()
  end

  def get_post_by(%{id: id}) do
    Repo.get_by(Post, id: id)
  end

  def get_public_posts(%{metadata: metadata}) do
    Post
    |> where([p], p.state == ^:published)
    |> preload([p], [:user_detail, :tags])
    |> paginate_posts(metadata)
  end

  def get_public_posts(%{url: url, metadata: metadata}) do
    Post
    |> where([p], p.state == ^:published)
    |> preload([p], [:user_detail, :tags])
    |> paginate_posts(metadata)
  end

  def get_posts_by_tag(%{url: url, metadata: metadata}) do
    Post
    |> join(:left, [p], tag in assoc(p, :tags))
    |> group_by([p], p.id)
    |> having([p, tag], fragment("? <@ array_agg(?)", ^[url], tag.url_name))
    |> preload([p], :tags)
    |> paginate_posts(metadata)
  end

  def get_user_posts(%{user_id: user_id, metadata: metadata}) do
    Post
    |> where([p], p.user_detail_id == ^user_id)
    |> preload([p], [:user_detail, :tags])
    |> paginate_posts(metadata)
  end

  def get_user_liked_posts(%{unique_name: unique_name, metadata: metadata}) do
    user = Accounts.get_user_detail(%{unique_name: unique_name})

    Post
    |> join(:left, [p], like in assoc(p, :likes))
    |> group_by([p], p.id)
    |> having([p, like], fragment("? <@ array_agg(?)", ^[user.id], like.user_detail_id))
    |> preload([p], [:likes, :user_detail])
    |> paginate_posts(metadata)
  end

  def get_user_posts(%{unique_name: unique_name, metadata: metadata}) do
    IO.inspect metadata
    Post
    |> join(:left, [p], user_detail in UserDetail, on: user_detail.unique_name == ^unique_name)
    |> where([p, user_detail], user_detail.unique_name == ^unique_name)
    |> preload([p], [:user_detail, :tags])
    |> paginate_posts(metadata)
  end

  def paginate_posts(query, metadata) when map_size(metadata) == 0 do
    Repo.paginate(query, cursor_fields: [:inserted_at, :id])
  end

  def paginate_posts(query, %{after: _after_cursor, before: _before} = params) do
    params = :maps.filter fn _, v -> v != nil end, params
    paginate_posts(query, params)
  end

  def paginate_posts(%{tag_url: tag_url, metadata: metadata}) do
  end

  def paginate_posts(query, %{before: before_cursor}) do
    Repo.paginate(query, before: before_cursor, cursor_fields: [:inserted_at, :id])
  end

  def paginate_posts(query, %{after: after_cursor}) do
    Repo.paginate(query, after: after_cursor, cursor_fields: [:inserted_at, :id])
  end

  def put_timestamps(attrs) when is_list(attrs) do
    attrs
    |> Enum.map(fn(row) -> put_timestamps(row) end)
  end

  def put_timestamps(attrs) when is_map(attrs) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    attrs
    |> Map.put(:inserted_at, now)
    |> Map.put(:updated_at, now)
  end

  def list_tags do
    Repo.all(Tag)
  end

  def create_tags(tags \\ [], user_detail_id) do
    tags
    |> put_timestamps()
    |> Enum.map(fn(row) ->
      case Repo.get_by(Tag, name: row.name) do
        nil ->
          row =
            row
            |> Map.put(:url_name, String.downcase(row.name))
            |> Map.put(:user_detail_id, user_detail_id)
          Tag.changeset(%Tag{}, row) |> Repo.insert!
        tag -> tag
      end
    end)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs, current_user) do
    current_user = Repo.preload(current_user, :user_detail)

    new_tags =
      attrs.tags
      |> Enum.filter(fn(tag) ->
        Map.has_key?(tag, :id) == false
      end)
      |> create_tags(current_user.id)

    gather_tags =
      Enum.filter(attrs.tags, fn(tag) ->
        if Map.has_key?(tag, :id) do
          Repo.get!(Tag, tag.id)
        end
      end) ++ new_tags

    %Post{user_detail_id: current_user.user_detail.id}
    |> Post.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, post} ->
        new_post =
          post
          |> Repo.preload([:tags, :user_detail])
          |> Ecto.Changeset.change
          |> Ecto.Changeset.put_assoc(:tags, gather_tags)
          |> Repo.update!()
        {:ok, new_post}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def like_post(post_url, current_user) do
    current_user = Repo.preload(current_user, :user_detail)
    case get_post_by(%{url: post_url}) do
      nil -> :noop
      post ->
        params =
          %{user_detail_id: current_user.user_detail.id, post_id: post.id}
          |> put_timestamps()

        %PostLikes{}
        |> PostLikes.changeset(params)
        |> Repo.insert()
    end
  end

  def delete_like(params, current_user) do
    case get_like(params) do
      nil -> :noop
      post -> Repo.delete(post)
    end
  end

  def get_like(%{like_id: like_id}) do
    Repo.get_by(PostLikes, id: like_id)
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
   |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post, current_user) do
    if post.user_detail.id == current_user.user_detail.id do
      Repo.delete(post)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
