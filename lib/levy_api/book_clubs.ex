defmodule LevyApi.BookClubs do
  @moduledoc """
  The BookClubs context.
  """

  import Ecto.Query, warn: false
  alias LevyApi.Repo

  alias LevyApi.BookClubs.BookClub

  @doc """
  Returns the list of book_clubs.

  ## Examples

      iex> list_book_clubs()
      [%BookClub{}, ...]

  """
  def list_book_clubs do
    Repo.all(BookClub)
  end

  @doc """
  Gets a single book_club.

  Raises `Ecto.NoResultsError` if the Book club does not exist.

  ## Examples

      iex> get_book_club!(123)
      %BookClub{}

      iex> get_book_club!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book_club!(id), do: Repo.get!(BookClub, id)

  @doc """
  Creates a book_club.

  ## Examples

      iex> create_book_club(%{field: value})
      {:ok, %BookClub{}}

      iex> create_book_club(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book_club(attrs \\ %{}) do
    %BookClub{}
    |> BookClub.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book_club.

  ## Examples

      iex> update_book_club(book_club, %{field: new_value})
      {:ok, %BookClub{}}

      iex> update_book_club(book_club, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book_club(%BookClub{} = book_club, attrs) do
    book_club
    |> BookClub.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BookClub.

  ## Examples

      iex> delete_book_club(book_club)
      {:ok, %BookClub{}}

      iex> delete_book_club(book_club)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book_club(%BookClub{} = book_club) do
    Repo.delete(book_club)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book_club changes.

  ## Examples

      iex> change_book_club(book_club)
      %Ecto.Changeset{source: %BookClub{}}

  """
  def change_book_club(%BookClub{} = book_club) do
    BookClub.changeset(book_club, %{})
  end
end
