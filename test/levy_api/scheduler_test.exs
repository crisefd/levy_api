defmodule LevyApi.SchedulerTest do
  use LevyApi.DataCase

  alias LevyApi.Scheduler

  describe "scheduled_meet_ups" do
    alias LevyApi.Scheduler.ScheduledMeetUp

    @valid_attrs %{name: "some name", where: "some where"}
    @update_attrs %{name: "some updated name", where: "some updated where"}
    @invalid_attrs %{name: nil, where: nil}

    def scheduled_meet_up_fixture(attrs \\ %{}) do
      {:ok, scheduled_meet_up} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scheduler.create_scheduled_meet_up()

      scheduled_meet_up
    end

    test "list_scheduled_meet_ups/0 returns all scheduled_meet_ups" do
      scheduled_meet_up = scheduled_meet_up_fixture()
      assert Scheduler.list_scheduled_meet_ups() == [scheduled_meet_up]
    end

    test "get_scheduled_meet_up!/1 returns the scheduled_meet_up with given id" do
      scheduled_meet_up = scheduled_meet_up_fixture()
      assert Scheduler.get_scheduled_meet_up!(scheduled_meet_up.id) == scheduled_meet_up
    end

    test "create_scheduled_meet_up/1 with valid data creates a scheduled_meet_up" do
      assert {:ok, %ScheduledMeetUp{} = scheduled_meet_up} = Scheduler.create_scheduled_meet_up(@valid_attrs)
      assert scheduled_meet_up.name == "some name"
      assert scheduled_meet_up.where == "some where"
    end

    test "create_scheduled_meet_up/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduler.create_scheduled_meet_up(@invalid_attrs)
    end

    test "update_scheduled_meet_up/2 with valid data updates the scheduled_meet_up" do
      scheduled_meet_up = scheduled_meet_up_fixture()
      assert {:ok, %ScheduledMeetUp{} = scheduled_meet_up} = Scheduler.update_scheduled_meet_up(scheduled_meet_up, @update_attrs)
      assert scheduled_meet_up.name == "some updated name"
      assert scheduled_meet_up.where == "some updated where"
    end

    test "update_scheduled_meet_up/2 with invalid data returns error changeset" do
      scheduled_meet_up = scheduled_meet_up_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduler.update_scheduled_meet_up(scheduled_meet_up, @invalid_attrs)
      assert scheduled_meet_up == Scheduler.get_scheduled_meet_up!(scheduled_meet_up.id)
    end

    test "delete_scheduled_meet_up/1 deletes the scheduled_meet_up" do
      scheduled_meet_up = scheduled_meet_up_fixture()
      assert {:ok, %ScheduledMeetUp{}} = Scheduler.delete_scheduled_meet_up(scheduled_meet_up)
      assert_raise Ecto.NoResultsError, fn -> Scheduler.get_scheduled_meet_up!(scheduled_meet_up.id) end
    end

    test "change_scheduled_meet_up/1 returns a scheduled_meet_up changeset" do
      scheduled_meet_up = scheduled_meet_up_fixture()
      assert %Ecto.Changeset{} = Scheduler.change_scheduled_meet_up(scheduled_meet_up)
    end
  end

  describe "scheduled_meet_up_attendees" do
    alias LevyApi.Scheduler.ScheduledMeetUpAttendee

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def scheduled_meet_up_attendee_fixture(attrs \\ %{}) do
      {:ok, scheduled_meet_up_attendee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scheduler.create_scheduled_meet_up_attendee()

      scheduled_meet_up_attendee
    end

    test "list_scheduled_meet_up_attendees/0 returns all scheduled_meet_up_attendees" do
      scheduled_meet_up_attendee = scheduled_meet_up_attendee_fixture()
      assert Scheduler.list_scheduled_meet_up_attendees() == [scheduled_meet_up_attendee]
    end

    test "get_scheduled_meet_up_attendee!/1 returns the scheduled_meet_up_attendee with given id" do
      scheduled_meet_up_attendee = scheduled_meet_up_attendee_fixture()
      assert Scheduler.get_scheduled_meet_up_attendee!(scheduled_meet_up_attendee.id) == scheduled_meet_up_attendee
    end

    test "create_scheduled_meet_up_attendee/1 with valid data creates a scheduled_meet_up_attendee" do
      assert {:ok, %ScheduledMeetUpAttendee{} = scheduled_meet_up_attendee} = Scheduler.create_scheduled_meet_up_attendee(@valid_attrs)
    end

    test "create_scheduled_meet_up_attendee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduler.create_scheduled_meet_up_attendee(@invalid_attrs)
    end

    test "update_scheduled_meet_up_attendee/2 with valid data updates the scheduled_meet_up_attendee" do
      scheduled_meet_up_attendee = scheduled_meet_up_attendee_fixture()
      assert {:ok, %ScheduledMeetUpAttendee{} = scheduled_meet_up_attendee} = Scheduler.update_scheduled_meet_up_attendee(scheduled_meet_up_attendee, @update_attrs)
    end

    test "update_scheduled_meet_up_attendee/2 with invalid data returns error changeset" do
      scheduled_meet_up_attendee = scheduled_meet_up_attendee_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduler.update_scheduled_meet_up_attendee(scheduled_meet_up_attendee, @invalid_attrs)
      assert scheduled_meet_up_attendee == Scheduler.get_scheduled_meet_up_attendee!(scheduled_meet_up_attendee.id)
    end

    test "delete_scheduled_meet_up_attendee/1 deletes the scheduled_meet_up_attendee" do
      scheduled_meet_up_attendee = scheduled_meet_up_attendee_fixture()
      assert {:ok, %ScheduledMeetUpAttendee{}} = Scheduler.delete_scheduled_meet_up_attendee(scheduled_meet_up_attendee)
      assert_raise Ecto.NoResultsError, fn -> Scheduler.get_scheduled_meet_up_attendee!(scheduled_meet_up_attendee.id) end
    end

    test "change_scheduled_meet_up_attendee/1 returns a scheduled_meet_up_attendee changeset" do
      scheduled_meet_up_attendee = scheduled_meet_up_attendee_fixture()
      assert %Ecto.Changeset{} = Scheduler.change_scheduled_meet_up_attendee(scheduled_meet_up_attendee)
    end
  end
end
