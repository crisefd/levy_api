defmodule LevyApi.AccountsTest do
  use LevyApi.DataCase

  alias LevyApi.Accounts
  # alias LevyApi.BookFeedBack.Vote

  describe "users" do
    alias LevyApi.Accounts.User

    @valid_attrs %{username: "john.doe@dummy.com", name: "John", surname: "Doe", email: "john.doe@dummy.com", password: "password123456"}
    @update_attrs %{username: "some updated username"}
    @invalid_attrs %{username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()
      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      {:ok, users } = Accounts.list_users()
      user_ids = users |> Enum.map(&(&1.id))
      assert user_ids == [user.id]
    end

    test "get_user!/1 returns the user with given id" do
      expected_user = user_fixture()
      {:ok, user} = Accounts.get_user(expected_user.id)
      assert user.id == expected_user.id
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.username == "john.doe@dummy.com"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert {:error, :not_found} == Accounts.get_user(user.id)
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
