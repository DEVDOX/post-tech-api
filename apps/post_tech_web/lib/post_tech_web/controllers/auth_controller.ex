defmodule PostTechWeb.AuthController do
  use PostTechWeb, :controller

  alias PostTech.Accounts
  alias PostTech.Accounts.User
  alias PostTech.Guardian

  action_fallback PostTechWeb.FallbackController

  def register(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params["user"]),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "authenticated_user.json", %{token: token, user: user})
    end
  end

  def login(conn, %{"user" => params}) do
    with %User{} = user <- Accounts.get_user_by_email!(params["email"]),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "authenticated_user.json", %{token: token, user: user})
    end
  end

  def callback(conn, %{"code" => code}) do
    # 返却されたコードからトークンを取得します
    token = PostTechWeb.Auth.GitHub.get_token!(code: code)

    # アクセストークンを使ってユーザ情報取得 API にリクエストします
    %{body: user} = OAuth2.Client.get!(token, "/user")

    # ユーザ情報をセッションへ詰めた後、ルートページへリダイレクトさせます
    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, token.access_token)
    |> redirect(to: "/")
  end
end
