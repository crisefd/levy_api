defmodule LevyApiWeb.BookClubControllerTest do
  use LevyApiWeb.ConnCase

  alias LevyApi.BookClubs
  alias LevyApi.BookClubs.BookClub

  @create_attrs %{
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:book_club) do
    {:ok, book_club} = BookClubs.create_book_club(@create_attrs)
    book_club
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all book_clubs", %{conn: conn} do
      conn = get(conn, Routes.book_club_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book_club" do
    test "renders book_club when data is valid", %{conn: conn} do
      conn = post(conn, Routes.book_club_path(conn, :create), book_club: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.book_club_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.book_club_path(conn, :create), book_club: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update book_club" do
    setup [:create_book_club]

    test "renders book_club when data is valid", %{conn: conn, book_club: %BookClub{id: id} = book_club} do
      conn = put(conn, Routes.book_club_path(conn, :update, book_club), book_club: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.book_club_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, book_club: book_club} do
      conn = put(conn, Routes.book_club_path(conn, :update, book_club), book_club: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book_club" do
    setup [:create_book_club]

    test "deletes chosen book_club", %{conn: conn, book_club: book_club} do
      conn = delete(conn, Routes.book_club_path(conn, :delete, book_club))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.book_club_path(conn, :show, book_club))
      end
    end
  end

  defp create_book_club(_) do
    book_club = fixture(:book_club)
    {:ok, book_club: book_club}
  end
end
