defmodule LevyApiWeb.VoteController do
  use LevyApiWeb, :controller
  alias LevyApi.Books
  alias LevyApi.BookFeedBack
  alias LevyApi.BookFeedBack.Vote
  alias LevyApi.Accounts

  action_fallback LevyApiWeb.FallbackController

  def create(conn, %{"book_id" => book_id, "user_id" => user_id, "vote" => vote_params}) do
    book = Books.get_book! book_id
    user = Accounts.get_user! user_id
    with {:ok, %Vote{} = _vote} <- BookFeedBack.create_vote(book, user, vote_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_club_book_path(conn, :show, book.book_club_id, book))
      |> render("show.json", book: book)
    end

  end

end
