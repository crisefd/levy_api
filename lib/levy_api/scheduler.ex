defmodule LevyApi.Scheduler do
  @moduledoc """
  The Scheduler context.
  """

  import Ecto.Query, warn: false
  alias LevyApi.Repo

  alias LevyApi.Scheduler.ScheduledMeetUp
  alias LevyApi.Scheduler.ScheduledMeetUpAttendee
  alias LevyApi.Books
  alias LevyApi.Books.Book
  alias LevyApi.Accounts.User

  @doc """
  Returns the list of scheduled_meet_ups.

  ## Examples

      iex> list_scheduled_meet_ups()
      [%ScheduledMeetUp{}, ...]

  """
  def list_scheduled_meet_ups do
    Repo.all(ScheduledMeetUp)
  end

  @doc """
  Gets a single scheduled_meet_up.

  Raises `Ecto.NoResultsError` if the Scheduled meet up does not exist.

  ## Examples

      iex> get_scheduled_meet_up!(123)
      %ScheduledMeetUp{}

      iex> get_scheduled_meet_up!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scheduled_meet_up!(id) do
      ScheduledMeetUp |> Repo.get!(id) |> Repo.preload(:books)
  end

  @doc """
  Creates a scheduled_meet_up.

  ## Examples

      iex> create_scheduled_meet_up(book, %{field: value})
      {:ok, %ScheduledMeetUp{}}

      iex> create_scheduled_meet_up(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheduled_meet_up(%Book{} = book, attrs \\ %{}) do
    book
    |> Ecto.build_assoc(:scheduled_meet_ups)
    |> ScheduledMeetUp.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scheduled_meet_up.

  ## Examples

      iex> update_scheduled_meet_up(scheduled_meet_up, %{field: new_value})
      {:ok, %ScheduledMeetUp{}}

      iex> update_scheduled_meet_up(scheduled_meet_up, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scheduled_meet_up(%ScheduledMeetUp{} = scheduled_meet_up, attrs) do
    scheduled_meet_up
    |> ScheduledMeetUp.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ScheduledMeetUp.

  ## Examples

      iex> delete_scheduled_meet_up(scheduled_meet_up)
      {:ok, %ScheduledMeetUp{}}

      iex> delete_scheduled_meet_up(scheduled_meet_up)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scheduled_meet_up(%ScheduledMeetUp{} = scheduled_meet_up) do
    Repo.delete(scheduled_meet_up)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scheduled_meet_up changes.

  ## Examples

      iex> change_scheduled_meet_up(scheduled_meet_up)
      %Ecto.Changeset{source: %ScheduledMeetUp{}}

  """
  def change_scheduled_meet_up(%ScheduledMeetUp{} = scheduled_meet_up) do
    ScheduledMeetUp.changeset(scheduled_meet_up, %{})
  end

  alias LevyApi.Scheduler.ScheduledMeetUpAttendee

  @doc """
  Returns the list of scheduled_meet_up_attendees.

  ## Examples

      iex> list_scheduled_meet_up_attendees()
      [%ScheduledMeetUpAttendee{}, ...]

  """
  def list_scheduled_meet_up_attendees do
    Repo.all(ScheduledMeetUpAttendee)
  end

  @doc """
  Gets a single scheduled_meet_up_attendee.

  Raises `Ecto.NoResultsError` if the Scheduled meet up attendee does not exist.

  ## Examples

      iex> get_scheduled_meet_up_attendee!(123)
      %ScheduledMeetUpAttendee{}

      iex> get_scheduled_meet_up_attendee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scheduled_meet_up_attendee!(id) do
    ScheduledMeetUpAttendee |> Repo.get!(id) |> Repo.preload([:scheduled_meet_ups, :users])
  end

  @doc """
  Creates a scheduled_meet_up_attendee.

  ## Examples

      iex> create_scheduled_meet_up_attendee(meet_up, user %{field: value})
      {:ok, %ScheduledMeetUpAttendee{}}

      iex> create_scheduled_meet_up_attendee(meet_up, user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheduled_meet_up_attendee(%ScheduledMeetUp{} = meet_up, %User{} = user, attrs \\ %{}) do
    attendee_attr = Map.merge(attrs, %{user_id: user.id, scheduled_meet_up_id: meet_up.id})
    attendee = struct(ScheduledMeetUpAttendee, attendee_attr)
    attendee |> Repo.insert()
  end

  @doc """
  Updates a scheduled_meet_up_attendee.

  ## Examples

      iex> update_scheduled_meet_up_attendee(scheduled_meet_up_attendee, %{field: new_value})
      {:ok, %ScheduledMeetUpAttendee{}}

      iex> update_scheduled_meet_up_attendee(scheduled_meet_up_attendee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scheduled_meet_up_attendee(%ScheduledMeetUpAttendee{} = scheduled_meet_up_attendee, attrs) do
    scheduled_meet_up_attendee
    |> ScheduledMeetUpAttendee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ScheduledMeetUpAttendee.

  ## Examples

      iex> delete_scheduled_meet_up_attendee(scheduled_meet_up_attendee)
      {:ok, %ScheduledMeetUpAttendee{}}

      iex> delete_scheduled_meet_up_attendee(scheduled_meet_up_attendee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scheduled_meet_up_attendee(%ScheduledMeetUpAttendee{} = scheduled_meet_up_attendee) do
    Repo.delete(scheduled_meet_up_attendee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scheduled_meet_up_attendee changes.

  ## Examples

      iex> change_scheduled_meet_up_attendee(scheduled_meet_up_attendee)
      %Ecto.Changeset{source: %ScheduledMeetUpAttendee{}}

  """
  def change_scheduled_meet_up_attendee(%ScheduledMeetUpAttendee{} = scheduled_meet_up_attendee) do
    ScheduledMeetUpAttendee.changeset(scheduled_meet_up_attendee, %{})
  end
end
