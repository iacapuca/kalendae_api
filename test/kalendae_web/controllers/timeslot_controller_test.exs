defmodule KalendaeWeb.TimeslotControllerTest do
  use KalendaeWeb.ConnCase

  import Kalendae.TimeslotsFixtures

  alias Kalendae.Timeslots.Timeslot

  @create_attrs %{
    activity_name: "some activity_name",
    date: ~D[2022-05-22],
    end_time: "some end_time",
    num_max_guests: 42,
    start_time: "some start_time"
  }
  @update_attrs %{
    activity_name: "some updated activity_name",
    date: ~D[2022-05-23],
    end_time: "some updated end_time",
    num_max_guests: 43,
    start_time: "some updated start_time"
  }
  @invalid_attrs %{activity_name: nil, date: nil, end_time: nil, num_max_guests: nil, start_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all timeslots", %{conn: conn} do
      conn = get(conn, Routes.timeslot_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create timeslot" do
    test "renders timeslot when data is valid", %{conn: conn} do
      conn = post(conn, Routes.timeslot_path(conn, :create), timeslot: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.timeslot_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "activity_name" => "some activity_name",
               "date" => "2022-05-22",
               "end_time" => "some end_time",
               "num_max_guests" => 42,
               "start_time" => "some start_time"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.timeslot_path(conn, :create), timeslot: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update timeslot" do
    setup [:create_timeslot]

    test "renders timeslot when data is valid", %{conn: conn, timeslot: %Timeslot{id: id} = timeslot} do
      conn = put(conn, Routes.timeslot_path(conn, :update, timeslot), timeslot: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.timeslot_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "activity_name" => "some updated activity_name",
               "date" => "2022-05-23",
               "end_time" => "some updated end_time",
               "num_max_guests" => 43,
               "start_time" => "some updated start_time"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, timeslot: timeslot} do
      conn = put(conn, Routes.timeslot_path(conn, :update, timeslot), timeslot: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete timeslot" do
    setup [:create_timeslot]

    test "deletes chosen timeslot", %{conn: conn, timeslot: timeslot} do
      conn = delete(conn, Routes.timeslot_path(conn, :delete, timeslot))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.timeslot_path(conn, :show, timeslot))
      end
    end
  end

  defp create_timeslot(_) do
    timeslot = timeslot_fixture()
    %{timeslot: timeslot}
  end
end
