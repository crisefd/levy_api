defmodule LevyApi.Scheduler do
  @moduledoc """
  The Scheduler context.
  """

  import Ecto.Query, warn: false
  alias LevyApi.Repo

  alias LevyApi.Scheduler.ScheduledMeetUp

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
  def get_scheduled_meet_up!(id), do: Repo.get!(ScheduledMeetUp, id)

  @doc """
  Creates a scheduled_meet_up.

  ## Examples

      iex> create_scheduled_meet_up(%{field: value})
      {:ok, %ScheduledMeetUp{}}

      iex> create_scheduled_meet_up(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheduled_meet_up(attrs \\ %{}) do
    %ScheduledMeetUp{}
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
  def get_scheduled_meet_up_attendee!(id), do: Repo.get!(ScheduledMeetUpAttendee, id)

  @doc """
  Creates a scheduled_meet_up_attendee.

  ## Examples

      iex> create_scheduled_meet_up_attendee(%{field: value})
      {:ok, %ScheduledMeetUpAttendee{}}

      iex> create_scheduled_meet_up_attendee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheduled_meet_up_attendee(attrs \\ %{}) do
    %ScheduledMeetUpAttendee{}
    |> ScheduledMeetUpAttendee.changeset(attrs)
    |> Repo.insert()
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