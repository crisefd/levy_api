defmodule LevyApi.VoteController do
  use LevyApiWeb, :controller
  alias LevyApi.Books
  alias LevyApi.BookFeedBack
  alias LevyApi.BookFeedBack.Vote

  def create(conn, %{"book_id" => book_id, "vote" => vote_params}) do
    book = Books.get_book! book_id
    with {:ok, %Vote{} = _vote} <- BookFeedBack.create_vote(book, vote_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_path(conn, :show, book))
      |> render("show.json", book: book)
    end

  end

end
