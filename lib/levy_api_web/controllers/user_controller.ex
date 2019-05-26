defmodule LevyApiWeb.UserController do
  use LevyApiWeb, :controller
  alias LevyApi.Accounts
  alias LevyApi.Accounts.User
  alias LevyApiWeb.Auth.Guardian

  action_fallback LevyApiWeb.FallbackController

  def index(conn, _params) do
    with {:ok, users} <- Accounts.list_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", users: users)
    else {:error, status} ->
       send_resp(conn, status, "Couldn't retrieve users")
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    else _ ->
        send_resp(conn, :not_found, "Couldn't authenticate user")
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("user.json", %{user: user, token: token})
      else _ ->
        send_resp(conn, :internal_server_error, "Couldn't create user")
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    else {:error, status} ->
      send_resp(conn, status, "")
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.get_user(id),
         {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    else {:error, status} ->
      send_resp(conn, status, "")
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Accounts.get_user(id),
         {:ok, %User{}}        <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "User deleted")
    else {:error, status} ->
      send_resp(conn, status, "Couldn't delete user")
    end
  end

end
