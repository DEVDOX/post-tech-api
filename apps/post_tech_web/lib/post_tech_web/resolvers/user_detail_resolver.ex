defmodule PostTechWeb.Resolvers.UserDetailResolver do
  alias PostTech.Accounts

  def show(_, %{strategy: strategy, strategy_id: strategy_id}, _) do
    {:ok, Accounts.get_user_detail(strategy, strategy_id)}
  end

  def show(_, %{unique_name: unique_name}, _) do
    {:ok, Accounts.get_user_detail(%{unique_name: unique_name})}
  end

  def create_contacts(_, %{params: contacts}, %{context: %{current_user: current_user}}) do
    case Accounts.create_contacts(contacts, current_user) do
      {:ok, payload} ->
        {:ok, payload}
      {:error, %Ecto.Changeset{} = changeset} -> 
        {:ok, changeset}
    end
  end
end
