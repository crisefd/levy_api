defmodule LevyApi.Books do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias LevyApi.Repo

  alias LevyApi.Books.Book
  alias LevyApi.BookClubs.BookClub

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books(book_club_id) do
    # Repo.all(Book)
    Repo.all(from book in Book, where: book.book_club_id == ^book_club_id)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Book |> Repo.get!(id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(book_club, %{field: value})
      {:ok, %Book{}}

      iex> create_book(book_club, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book( %BookClub{} = book_club, attrs \\ %{}) do
    book_club
    |> Ecto.build_assoc(:books)
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{source: %Book{}}

  """
  def change_book(%Book{} = book) do
    Book.changeset(book, %{})
  end
end
