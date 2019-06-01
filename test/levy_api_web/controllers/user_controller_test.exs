defmodule LevyApiWeb.UserControllerTest do
  use LevyApiWeb.ConnCase

  alias LevyApi.Accounts
  alias LevyApi.Accounts.User

  @create_attrs %{
    username: "some username",
    email: "test@example.com",
    password: "password123456",
  }
  @update_attrs %{
    username: "some updated username",
    email: "test@example.com",
    password: "password123456",
  }
  @invalid_attrs %{username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      response = json_response(conn, 200)
      assert response["rows"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "username" => "some username"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert response(conn, 400)
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      response = json_response(conn, 200)
      user_id = user.id
      assert user_id = response["id"]

      conn = get(conn, Routes.user_path(conn, :show, user_id))
      response = json_response(conn, 200)
      assert user_id = response["id"]
      assert "some updated username" = response["username"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert response(conn, 400)
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)
      conn = get(conn, Routes.user_path(conn, :show, user))
      assert response(conn, 404)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
