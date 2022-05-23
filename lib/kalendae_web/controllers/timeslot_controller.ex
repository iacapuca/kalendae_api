defmodule KalendaeWeb.TimeslotController do
  use KalendaeWeb, :controller

  plug JSONAPI.QueryParser,
    view: KalendaeWeb.TimeslotView

  alias Kalendae.Timeslots
  alias Kalendae.Timeslots.Timeslot

  action_fallback KalendaeWeb.FallbackController

  def index(conn, _params) do
    timeslots = Timeslots.list_timeslots()
    render(conn, "index.json", %{data: timeslots})
  end

  def create(conn, params) do
    with {:ok, %Timeslot{} = timeslot} <- Timeslots.create_timeslot(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.timeslot_path(conn, :show, timeslot))
      |> render("show.json", %{data: timeslot})
    end
  end

  def show(conn, params) do
    timeslot = Timeslots.get_timeslot!(params["id"])
    render(conn, "show.json", %{data: timeslot})
  end

  def update(conn, params) do
    IO.inspect(params)
    timeslot = Timeslots.get_timeslot!(params["id"])

    with {:ok, %Timeslot{} = timeslot} <- Timeslots.update_timeslot(timeslot, params) do
      render(conn, "show.json", %{data: timeslot})
    end
  end

  def delete(conn, params) do
    timeslot = Timeslots.get_timeslot!(params["id"])

    with {:ok, %Timeslot{}} <- Timeslots.delete_timeslot(timeslot) do
      send_resp(conn, :no_content, "")
    end
  end
end
