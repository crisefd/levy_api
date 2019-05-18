defmodule LevyApiWeb.ScheduledMeetUpAttendeeController do
  use LevyApiWeb, :controller

  alias LevyApi.Scheduler
  alias LevyApi.Scheduler.ScheduledMeetUpAttendee
  alias LevyApi.Accounts

  def index(conn, _params) do
    scheduled_meet_up_attendees = Scheduler.list_scheduled_meet_up_attendees()
    render(conn, "index.json", scheduled_meet_up_attendees: scheduled_meet_up_attendees)
  end

  def create(conn, %{"scheduled_meep_up_id" => scheduled_meep_up_id,
                     "user_id" => user_id,
                     "scheduled_meet_up_attendee" => scheduled_meet_up_attendee_params}) do
    scheduled_meet_up = Scheduler.get_scheduled_meet_up! scheduled_meep_up_id
    user = Accounts.get_user! user_id
    with {:ok, _scheduled_meet_up_attendee}
          <- Scheduler
          .create_scheduled_meet_up_attendee(scheduled_meet_up, user,  scheduled_meet_up_attendee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.scheduled_meet_up_path(conn, :show, scheduled_meet_up))
      |> render("show.json", scheduled_meet_up: scheduled_meet_up)
    end
  end

  def delete(conn, %{"id" => id}) do
    scheduled_meet_up_attendee =  Scheduler.get_scheduled_meet_up_attendee!(id)
    with {:ok, %ScheduledMeetUpAttendee{}} <- Scheduler.delete_scheduled_meet_up_attendee(scheduled_meet_up_attendee) do
      send_resp(conn, :no_content, "")
    end
  end

end
