defmodule LevyApiWeb.Auth.Guardian do
  use Guardian, otp_app: :levy_api
  alias LevyApi.Accounts
  alias LevyApi.Accounts.User

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Accounts.get_user!(id)
    {:ok,  resource}
  end

  def authenticate(email, password) do
    with {:ok, %User{} = user} <- Accounts.get_user_by_email(email) do
      case validate_password(password, user.encrypted_password) do
         true -> create_token(user)
         false -> {:error, :unauthorized}
      end
    end
  end

  defp validate_password(password, encrypted_password) do
    Bcrypt.verify_pass(password, encrypted_password)
  end

  defp create_token( %User{} = user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end

end
