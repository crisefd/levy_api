defmodule LevyApiWeb.CommentController do
  use LevyApiWeb, :controller
  alias LevyApi.Books
  alias LevyApi.BookFeedBack.Comment
  alias LevyApi.BookFeedBack
  alias LevyApi.Accounts

  action_fallback LevyApiWeb.FallbackController

  def create(conn, %{"book_id" => book_id, "user_id" => user_id, "comment" => comment_params}) do
    book = Books.get_book! book_id
    user = Accounts.get_user! user_id
    with {:ok, %Comment{} = _comment} <- BookFeedBack.create_comment(book, user, comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_club_book_path(conn, :show, book.book_club_id, book))
      |> render("show.json", book: book)
    end

  end

end
