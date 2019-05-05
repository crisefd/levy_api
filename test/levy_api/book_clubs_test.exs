defmodule LevyApi.BookClubsTest do
  use LevyApi.DataCase

  alias LevyApi.BookClubs

  describe "book_clubs" do
    alias LevyApi.BookClubs.BookClub

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def book_club_fixture(attrs \\ %{}) do
      {:ok, book_club} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BookClubs.create_book_club()

      book_club
    end

    test "list_book_clubs/0 returns all book_clubs" do
      book_club = book_club_fixture()
      assert BookClubs.list_book_clubs() == [book_club]
    end

    test "get_book_club!/1 returns the book_club with given id" do
      book_club = book_club_fixture()
      assert BookClubs.get_book_club!(book_club.id) == book_club
    end

    test "create_book_club/1 with valid data creates a book_club" do
      assert {:ok, %BookClub{} = book_club} = BookClubs.create_book_club(@valid_attrs)
      assert book_club.description == "some description"
      assert book_club.name == "some name"
    end

    test "create_book_club/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookClubs.create_book_club(@invalid_attrs)
    end

    test "update_book_club/2 with valid data updates the book_club" do
      book_club = book_club_fixture()
      assert {:ok, %BookClub{} = book_club} = BookClubs.update_book_club(book_club, @update_attrs)
      assert book_club.description == "some updated description"
      assert book_club.name == "some updated name"
    end

    test "update_book_club/2 with invalid data returns error changeset" do
      book_club = book_club_fixture()
      assert {:error, %Ecto.Changeset{}} = BookClubs.update_book_club(book_club, @invalid_attrs)
      assert book_club == BookClubs.get_book_club!(book_club.id)
    end

    test "delete_book_club/1 deletes the book_club" do
      book_club = book_club_fixture()
      assert {:ok, %BookClub{}} = BookClubs.delete_book_club(book_club)
      assert_raise Ecto.NoResultsError, fn -> BookClubs.get_book_club!(book_club.id) end
    end

    test "change_book_club/1 returns a book_club changeset" do
      book_club = book_club_fixture()
      assert %Ecto.Changeset{} = BookClubs.change_book_club(book_club)
    end
  end
end
