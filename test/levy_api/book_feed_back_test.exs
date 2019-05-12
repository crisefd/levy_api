defmodule LevyApi.BookFeedBackTest do
  use LevyApi.DataCase

  alias LevyApi.BookFeedBack
  alias LevyApi.BookFeedBack.Vote
  alias LevyApi.Books
  alias LevyApi.Books.Book
  alias LevyApi.Accounts
  alias LevyApi.Accounts.User
  alias LevyApi.BookClubs
  alias LevyApi.BookFeedBack.Comment


  @user_valid_attrs %{username: "john.doe@dummy.com", name: "John", surname: "Doe"}
  @book_club_valid_attrs %{description: "some description", name: "some name"}
  @book_valid_attrs %{author: "some author", isbn: "some isbn", name: "some name"}
  @comment_valid_attrs %{content: "some content"}
  @comment_invalid_attrs %{user_id: nil, book_id: nil}
  @vote_valid_attrs %{}
  @vote_invalid_attrs %{user_id: nil, book_id: nil}



  def book_fixture(book_club, attrs \\ %{}) do
    new_attrs = attrs |> Enum.into(@book_valid_attrs)
    {:ok, book} = Books.create_book(book_club, new_attrs)
    book
  end

  def book_club_fixture(attrs \\ %{}) do
    {:ok, book_club} =
      attrs
      |> Enum.into(@book_club_valid_attrs)
      |> BookClubs.create_book_club()
    book_club
  end

  def user_fixture(attrs \\ %{}) do
     {:ok, user} =
       attrs
       |> Enum.into(@user_valid_attrs)
       |> Accounts.create_user()
      user
   end

  def vote_fixture(book, user, attrs \\ %{}) do
     new_attrs = attrs |> Enum.into(@vote_valid_attrs)
    {:ok, vote} = BookFeedBack.create_vote( book, user, new_attrs)
    vote
  end

  def comment_fixture(book, user, attrs \\ %{}) do
    new_attrs = attrs |> Enum.into(@vote_valid_attrs)
    {:ok, comment} = BookFeedBack.create_comment( book, user, new_attrs)
    comment
  end

  describe "votes" do


    setup do
      book_club = book_club_fixture()
      user = user_fixture()
      book = book_fixture(book_club, %{})
      vote = vote_fixture(book, user, %{})
      # on_exit fn ->
      #   BookFeedBack.delete_vote(vote)
      # end
      %{vote: vote}
    end

    test "get_vote!/1 returns the vote with given id", state do
      vote = state[:vote]
      assert BookFeedBack.get_vote!(vote.id) == vote
    end

    test "create_vote/1 with valid data creates a vote" do
      book_club = book_club_fixture()
      user = user_fixture()
      book = book_fixture(book_club, %{})
      assert {:ok, %Vote{} = vote} = BookFeedBack.create_vote(book, user, %{})
      BookFeedBack.delete_vote(vote)
    end

    @tag :skip
    test "create_vote/1 with invalid data returns error changeset" do
      book_club = book_club_fixture()
      user = user_fixture()
      book = book_fixture(book_club, %{})
      assert {:error, _} = BookFeedBack.create_vote(%Book{}, nil, %{})
    end

    test "delete_vote/1 deletes the vote" do
      book_club = book_club_fixture()
      user = user_fixture()
      book = book_fixture(book_club, %{})
      assert {:ok, %Vote{} = vote} = BookFeedBack.create_vote(book, user, %{})
      assert {:ok, %Vote{}} = BookFeedBack.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> BookFeedBack.get_vote!(vote.id) end
    end

  end

  describe "comments" do


  setup do
    book_club = book_club_fixture()
    user = user_fixture()
    book = book_fixture(book_club, %{})
    comment = comment_fixture(book, user, @comment_valid_attrs)
    %{comment: comment}
  end

    test "list_comments/0 returns all comments", state do
      comment = state[:comment]
      assert BookFeedBack.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id", state do
      comment = state[:comment]
      assert BookFeedBack.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      book_club = book_club_fixture()
      user = user_fixture()
      book = book_fixture(book_club, %{})
      assert {:ok, %Comment{} = comment} = BookFeedBack.create_comment(book, user, @comment_valid_attrs)
      assert comment.content == "some content"
    end

    @tag :skip
    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookFeedBack.create_comment(nil, nil, @invalid_attrs)
    end

    @tag :skip
    test "update_comment/2 with valid data updates the comment" do
      # comment = comment_fixture()
      # assert {:ok, %Comment{} = comment} = BookFeedBack.update_comment(comment, @update_attrs)
      # assert comment.content == "some updated content"
    end

    @tag :skip
    test "update_comment/2 with invalid data returns error changeset" do
      # comment = comment_fixture()
      # assert {:error, %Ecto.Changeset{}} = BookFeedBack.update_comment(comment, @invalid_attrs)
      # assert comment == BookFeedBack.get_comment!(comment.id)
    end

    @tag :skip
    test "delete_comment/1 deletes the comment" do
      # comment = comment_fixture()
      # assert {:ok, %Comment{}} = BookFeedBack.delete_comment(comment)
      # assert_raise Ecto.NoResultsError, fn -> BookFeedBack.get_comment!(comment.id) end
    end

    @tag :skip
    test "change_comment/1 returns a comment changeset" do
      # comment = comment_fixture()
      # assert %Ecto.Changeset{} = BookFeedBack.change_comment(comment)
    end
   end


end
