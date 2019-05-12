defmodule LevyApi.BooksTest do
  use LevyApi.DataCase

  alias LevyApi.Books
  alias LevyApi.Books.Book
  alias LevyApi.BookClubs
  alias LevyApi.BookClubs.BookClub

  describe "books" do


    @book_valid_attrs %{author: "some author", isbn: "some isbn", name: "some name"}
    @book_update_attrs %{author: "some updated author", isbn: "some updated isbn", name: "some updated name"}
    @book_invalid_attrs %{author: nil, isbn: nil, name: nil}
    @book_club_valid_attrs %{description: "some description", name: "some name"}

    def book_club_fixture(attrs \\ %{}) do
      {:ok, book_club} =
        attrs
        |> Enum.into(@book_club_valid_attrs)
        |> BookClubs.create_book_club()
      book_club
    end

    def book_fixture(book_club, attrs \\ %{}) do
      new_attrs = attrs |> Enum.into(@book_valid_attrs)
      {:ok, book} = Books.create_book( book_club, new_attrs)
      book
    end

    setup do
      book_club = book_club_fixture()
      book = book_fixture(book_club)
      %{book: book}
    end

    test "list_books/0 returns all books", state do
      book = state[:book]
      assert Books.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id", state do
      book = state[:book]
      assert Books.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      book_club = book_club_fixture()
      assert {:ok, %Book{} = book} = Books.create_book(book_club, @book_valid_attrs)
      assert book.author == "some author"
      assert book.isbn == "some isbn"
      assert book.name == "some name"
    end

    test "create_book/1 with invalid data returns error changeset" do
      book_club = book_club_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.create_book(book_club, @book_invalid_attrs)
    end

    test "update_book/2 with valid data updates the book", state do
      book = state[:book]
      assert {:ok, %Book{} = book} = Books.update_book(book, @book_update_attrs)
      assert book.author == "some updated author"
      assert book.isbn == "some updated isbn"
      assert book.name == "some updated name"
    end

    test "update_book/2 with invalid data returns error changeset", state do
      book = state[:book]
      assert {:error, %Ecto.Changeset{}} = Books.update_book(book, @book_invalid_attrs)
      assert book == Books.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book_club = book_club_fixture()
      book = book_fixture(book_club)
      assert {:ok, %Book{}} = Books.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book_club = book_club_fixture()
      book = book_fixture(book_club)
      assert %Ecto.Changeset{} = Books.change_book(book)
    end
  end
end
