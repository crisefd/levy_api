defmodule LevyApi.CommentController do
  use LevyApiWeb, :controller
  alias LevyApi.Books
  alias LevyApi.BookFeedBack.Comment
  alias LevyApi.BookFeedBack

  def create(conn, %{"book_id" => book_id, "comment" => comment_params}) do
    book = Books.get_book! book_id
    with {:ok, %Comment{} = _comment} <- BookFeedBack.create_comment(book, comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_path(conn, :show, book))
      |> render("show.json", book: book)
    end

  end

end
