defmodule TransportersHubWeb.Auth.Guardian do
  use Guardian, otp_app: :transporters_hub
  alias TransportersHub.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_claims) do
    {:error, :no_subject}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_resource}
  end

  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil -> {:error, :unauthored}
      account ->
        case validate_password(password, account.hash_password) do
          true -> create_token(account)
          false -> {:error, :unauthorized}
        end
    end
  end


  defp validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)
    {:ok, account, token}
  end
end
