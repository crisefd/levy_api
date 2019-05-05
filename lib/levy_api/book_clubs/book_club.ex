defmodule LevyApi.BookClubs.BookClub do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:name, :description]

  schema "book_clubs" do
    field :description, :string
    field :name, :string
    has_many :books, Book
    timestamps()
  end

  @doc false
  def changeset(book_club, attrs) do
    book_club
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
