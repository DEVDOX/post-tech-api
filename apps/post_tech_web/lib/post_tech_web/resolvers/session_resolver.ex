defmodule PostTechWeb.Resolvers.SessionResolver do
  alias PostTech.{Accounts, Guardian}
  import AbsintheErrorPayload.Payload

  alias AbsintheErrorPayload.ValidationMessage

  def login(_, requestParams, _) do
    %{params: params} = requestParams

    with true <-  PostTechWeb.Auth.GitHubApi.check_token(params[:strategy_token]) do
         {:ok, user} = Accounts.get_or_create(params)
         {:ok, token, _} = Guardian.encode_and_sign(user) 
      {:ok, %{token: token, user_detail: user}}
    else
      error ->
        {:error, "user not found"}
    end
  end
end

