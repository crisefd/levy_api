defmodule LevyApiWeb.BookControllerTest do
  use LevyApiWeb.ConnCase

  alias LevyApi.Books
  alias LevyApi.Books.Book
  alias LevyApi.BookClubs
  alias Plug.Conn

  @create_attrs %{
    author: "some author",
    isbn: "some isbn",
    name: "some name"
  }
  @update_attrs %{
    author: "some updated author",
    isbn: "some updated isbn",
    name: "some updated name"
  }
  @invalid_attrs %{author: nil, isbn: nil, name: nil}

  def fixture(:book) do
    {:ok, book_club}  =  BookClubs.create_book_club(%{description: "some description", name: "some name"})
    {:ok, book} = Books.create_book(book_club, @create_attrs)
    book
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end


  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get(conn, Routes.book_club_book_path(conn, :index, 0))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book" do

    test "renders book when data is valid", %{conn: conn} do

      {:ok, book_club } =  BookClubs.create_book_club(%{description: "some description", name: "some name"})
      conn = post(conn, Routes.book_club_book_path(conn, :create, book_club.id), book: @create_attrs )
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.book_club_book_path(conn, :show, book_club.id, id))

      assert %{
               "id" => id,
               "author" => "some author",
               "isbn" => "some isbn",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      {:ok, book_club } =  BookClubs.create_book_club(%{description: "some description", name: "some name"})
      conn = post(conn, Routes.book_club_book_path(conn, :create, book_club.id),book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end


  describe "update book" do
    setup [:create_book]
    @tag :skip
    test "renders book when data is valid", %{conn: conn, book: %Book{id: id} = book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.book_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some updated author",
               "isbn" => "some updated isbn",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end
    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book" do
    setup [:create_book]
    @tag :skip
    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete(conn, Routes.book_path(conn, :delete, book))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.book_path(conn, :show, book))
      end
    end
  end

  defp create_book(_) do
    book = fixture(:book)
    {:ok, book: book}
  end
end
