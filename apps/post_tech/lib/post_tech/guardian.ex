defmodule PostTech.Guardian do
  use Guardian, otp_app: :post_tech

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.user_id)}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    case PostTech.Accounts.get_user!(id) do
      nil ->
        {:error, :reason_for_error}
      user ->
        {:ok, user}
    end
  end

  def resource_from_claims(_) do
    {:error, :reason_for_error}
  end
end
