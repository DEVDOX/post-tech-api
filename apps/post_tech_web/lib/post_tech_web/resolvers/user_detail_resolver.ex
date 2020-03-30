defmodule PostTechWeb.Resolvers.UserDetailResolver do
  alias PostTech.Accounts

  def show(_, %{strategy: strategy, strategy_id: strategy_id}, _) do
    {:ok, Accounts.get_user_detail(strategy, strategy_id)}
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
