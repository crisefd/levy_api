defmodule LevyApiWeb.ScheduledMeetUpController do
  use LevyApiWeb, :controller

  alias LevyApi.Scheduler
  alias LevyApi.Scheduler.ScheduledMeetUp
  alias LevyApi.Books

  def index(conn, _params) do
    scheduled_meet_ups = Scheduler.list_scheduled_meet_ups()
    render(conn, "index.json", scheduled_meet_ups: scheduled_meet_ups)
  end

  def create(conn, %{"book_id" => book_id,
                     "scheduled_meet_up" => scheduled_meet_up_params}) do
    book = Books.get_book! book_id
    with {:ok, scheduled_meet_up}
          <- Scheduler.create_scheduled_meet_up(book, scheduled_meet_up_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.scheduled_meet_up_path(conn, :show, scheduled_meet_up))
      |> render("show.json", scheduled_meet_up: scheduled_meet_up)
    end
  end

  def show(conn, %{"id" => id}) do
    scheduled_meet_up = Scheduler.get_scheduled_meet_up!(id)
    render(conn, "show.json", scheduled_meet_up: scheduled_meet_up)
  end

  def update(conn, %{"id" => id, "scheduled_meet_up" => scheduled_meet_up_params}) do
    scheduled_meet_up = Scheduler.get_scheduled_meet_up!(id)
    with {:ok, %ScheduledMeetUp{} = scheduled_meet_up}
          <- Scheduler.update_scheduled_meet_up(scheduled_meet_up, scheduled_meet_up_params) do
      render(conn, "show.json", scheduled_meet_up: scheduled_meet_up)
    end
  end

  def delete(conn, %{"id" => id}) do
    scheduled_meet_up =  Scheduler.get_scheduled_meet_up!(id)
    with {:ok, %ScheduledMeetUp{}} <- Scheduler.delete_scheduled_meet_up(scheduled_meet_up) do
      send_resp(conn, :no_content, "")
    end
  end

end
