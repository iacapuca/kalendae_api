defmodule KalendaeWeb.TimeslotController do
  use KalendaeWeb, :controller

  alias Kalendae.Timeslots
  alias Kalendae.Timeslots.Timeslot

  action_fallback KalendaeWeb.FallbackController

  def index(conn, _params) do
    timeslots = Timeslots.list_timeslots()
    render(conn, "index.json", timeslots: timeslots)
  end

  def create(conn, %{"timeslot" => timeslot_params}) do
    with {:ok, %Timeslot{} = timeslot} <- Timeslots.create_timeslot(timeslot_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.timeslot_path(conn, :show, timeslot))
      |> render("show.json", timeslot: timeslot)
    end
  end

  def show(conn, %{"id" => id}) do
    timeslot = Timeslots.get_timeslot!(id)
    render(conn, "show.json", timeslot: timeslot)
  end

  def update(conn, %{"id" => id, "timeslot" => timeslot_params}) do
    timeslot = Timeslots.get_timeslot!(id)

    with {:ok, %Timeslot{} = timeslot} <- Timeslots.update_timeslot(timeslot, timeslot_params) do
      render(conn, "show.json", timeslot: timeslot)
    end
  end

  def delete(conn, %{"id" => id}) do
    timeslot = Timeslots.get_timeslot!(id)

    with {:ok, %Timeslot{}} <- Timeslots.delete_timeslot(timeslot) do
      send_resp(conn, :no_content, "")
    end
  end
end
