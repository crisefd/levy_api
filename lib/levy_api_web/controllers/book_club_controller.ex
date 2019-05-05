defmodule LevyApiWeb.BookClubController do
  use LevyApiWeb, :controller

  alias LevyApi.BookClubs
  alias LevyApi.BookClubs.BookClub

  action_fallback LevyApiWeb.FallbackController

  def index(conn, _params) do
    book_clubs = BookClubs.list_book_clubs()
    render(conn, "index.json", book_clubs: book_clubs)
  end

  def create(conn, %{"book_club" => book_club_params}) do
    with {:ok, %BookClub{} = book_club} <- BookClubs.create_book_club(book_club_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_club_path(conn, :show, book_club))
      |> render("show.json", book_club: book_club)
    end
  end

  def show(conn, %{"id" => id}) do
    book_club = BookClubs.get_book_club!(id)
    render(conn, "show.json", book_club: book_club)
  end

  def update(conn, %{"id" => id, "book_club" => book_club_params}) do
    book_club = BookClubs.get_book_club!(id)

    with {:ok, %BookClub{} = book_club} <- BookClubs.update_book_club(book_club, book_club_params) do
      render(conn, "show.json", book_club: book_club)
    end
  end

  def delete(conn, %{"id" => id}) do
    book_club = BookClubs.get_book_club!(id)

    with {:ok, %BookClub{}} <- BookClubs.delete_book_club(book_club) do
      send_resp(conn, :no_content, "")
    end
  end
end
