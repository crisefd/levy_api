defmodule LevyApiWeb.BookView do
  use LevyApiWeb, :view
  alias LevyApiWeb.BookView

  def render("index.json", %{books: books}) do
    %{data: render_many(books, BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{id: book.id,
      name: book.name,
      isbn: book.isbn,
      author: book.author}
  end
end
