defmodule LevyApiWeb.BookController do
  use LevyApiWeb, :controller

  alias LevyApi.Books
  alias LevyApi.Books.Book
  alias LevyApi.BookClubs

  action_fallback LevyApiWeb.FallbackController

  def index(conn, %{"book_club_id" => book_club_id }) do
    books = Books.list_books(book_club_id)
    render(conn, "index.json", books: books)
  end

  def create(conn, %{ "book_club_id" => book_club_id, "book" => book_params}) do
    book_club = BookClubs.get_book_club! book_club_id
    with {:ok, %Book{} = book} <- Books.create_book(book_club, book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_club_book_path(conn, :show, book_club.id, book))
      |> render("show.json", book: book)
    end
  end

  def show(conn, %{ "book_club_id" => book_club_id,  "id" => id}) do
    book = Books.get_book!(id)
    render(conn, "show.json", book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Books.get_book!(id)

    with {:ok, %Book{} = book} <- Books.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Books.get_book!(id)

    with {:ok, %Book{}} <- Books.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
