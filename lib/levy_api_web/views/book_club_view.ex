defmodule LevyApiWeb.BookClubView do
  use LevyApiWeb, :view
  alias LevyApiWeb.BookClubView

  def render("index.json", %{book_clubs: book_clubs}) do
    %{data: render_many(book_clubs, BookClubView, "book_club.json")}
  end

  def render("show.json", %{book_club: book_club}) do
    %{data: render_one(book_club, BookClubView, "book_club.json")}
  end

  def render("book_club.json", %{book_club: book_club}) do
    %{id: book_club.id,
      name: book_club.name,
      description: book_club.description}
  end
end
