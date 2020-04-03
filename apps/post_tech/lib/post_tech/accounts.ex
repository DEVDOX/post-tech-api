defmodule PostTech.Accounts do
  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias PostTech.Repo
  alias PostTech.Accounts.{User, UserDetail, UserContacts}

  def list_users do
    Repo.all(User)
  end

  ## User

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def create_user(repo, %{}, params \\ %{}) do
    user =
      %User{}
      |> User.changeset(params)
      |> repo.insert()

    case user do
      {:ok, user} ->
        %UserDetail{user_id: user.id}
        |> UserDetail.changeset(params)
        |> repo.insert()
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  ## UserDetail

  def list_user_details do
    Repo.all(UserDetail)
  end

  def get_user_detail(strategy, id) when is_integer(id) do
    id = Integer.to_string(id)
    get_user_detail(strategy, id)
  end

  def get_user_detail("github", id) do
    query =
      from u in UserDetail, 
      join: a in assoc(u, :user), 
      where: a.github_id == ^id

    Repo.one(query)
  end

  def get_user_detail(%{unique_name: unique_name}) do
    UserDetail
    |> where([u], u.unique_name == ^unique_name)
    |> Repo.one()
  end

  def get_or_create(params) do
    query =
      from u in UserDetail, 
      join: a in assoc(u, :user), 
      where: a.github_id == ^params[:strategy_id]

    case Repo.one(query) do
      nil ->
        create_user_detail(params)
      user ->
        {:ok, user}
    end
  end

  def create_user_detail(params) do
    Multi.new()
    |> Multi.run(:create_user, __MODULE__, :create_user, [params])
    |> Repo.transaction()
  end

  def create_contacts(contacts, current_user) do
    types = Enum.map(contacts, fn contact -> contact.type end)
    current_user = Repo.preload(current_user, :user_detail)

    if length(types) > 0 do
      current_contacts = 
        UserContacts
        |> where([c], c.user_detail_id == ^current_user.user_detail.id)
        |> where([c], c.type in ^types)
        |> Repo.all()
        |> IO.inspect

      if length(current_contacts) == 0 do
        # insert all
        current_user.user_detail
        |> Repo.preload(:contacts)
        |> Ecto.Changeset.change
        |> Ecto.Changeset.put_assoc(:contacts, contacts)
        |> Repo.update!()
      else
        IO.inspect contacts
        IO.inspect current_contacts
        Enum.each(current_contacts, fn contact ->

        end)
      end
    end
  end
end
