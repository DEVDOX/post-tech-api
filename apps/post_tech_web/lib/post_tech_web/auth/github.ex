defmodule PostTechWeb.Auth.GitHubApi do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, [{"User-Agent", "tesla"}]
  plug Tesla.Middleware.JSON

  def user_repos(login) do
    get("/")
  end

  def check_token(token) do
    case get("/user",  headers: [{"authorization", "token " <> token}]) do
      {:ok, result} ->
        Map.get(result, :status) == 200
      {:error, _} ->
        {:error, :invalid_token}
    end
  end
end
