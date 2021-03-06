defmodule LevyApi.BookFeedBack do
  @moduledoc """
  The BookFeedBack context.
  """

  import Ecto.Query, warn: false
  alias LevyApi.Repo

  alias LevyApi.BookFeedBack.Vote
  alias LevyApi.Books.Book

  alias LevyApi.Accounts.User

  # @doc """
  # Returns the list of votes.

  # ## Examples

  #     iex> list_votes()
  #     [%Vote{}, ...]

  # """
  # def list_votes do
  #   v from Vote, preload: [:users, :books] |> Repo.all(Vote)
  # end

  @doc """
  Gets a single vote.

  Raises `Ecto.NoResultsError` if the Vote does not exist.

  ## Examples

      iex> get_vote!(123)
      %Vote{}

      iex> get_vote!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vote!(id), do: Vote |> Repo.get!(id)

  @doc """
  Creates a vote.

  ## Examples

      iex> create_vote(book, user, %{field: value})
      {:ok, %Vote{}}

      iex> create_vote(book, user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vote(%Book{} = book, %User{} = user, attrs \\ %{}) do
    vote_attrs = Map.merge(attrs, %{user_id: user.id, book_id: book.id})
    vote = struct(Vote, vote_attrs)
    vote |> Repo.insert()
  end

  @doc """
  Updates a vote.

  ## Examples

      iex> update_vote(vote, %{field: new_value})
      {:ok, %Vote{}}

      iex> update_vote(vote, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vote(%Vote{} = vote, attrs) do
    vote
    |> Vote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Vote.

  ## Examples

      iex> delete_vote(vote)
      {:ok, %Vote{}}

      iex> delete_vote(vote)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vote(%Vote{} = vote) do
    Repo.delete(vote)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vote changes.

  ## Examples

      iex> change_vote(vote)
      %Ecto.Changeset{source: %Vote{}}

  """
  def change_vote(%Vote{} = vote) do
    Vote.changeset(vote, %{})
  end

  alias LevyApi.BookFeedBack.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(book, %{field: value})
      {:ok, %Comment{}}

      iex> create_comment(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment( %Book{} = book, %User{} = user, attrs \\ %{}) do
    comment_attrs = Map.merge(attrs, %{book_id: book.id, user_id: user.id})
    comment = struct(Comment, comment_attrs)
    comment |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{source: %Comment{}}

  """
  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end
end
