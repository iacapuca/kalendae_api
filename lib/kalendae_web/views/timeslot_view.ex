defmodule KalendaeWeb.TimeslotView do
  use KalendaeWeb, :view
  alias KalendaeWeb.TimeslotView

  def render("index.json", %{timeslots: timeslots}) do
    %{data: render_many(timeslots, TimeslotView, "timeslot.json")}
  end

  def render("show.json", %{timeslot: timeslot}) do
    %{data: render_one(timeslot, TimeslotView, "timeslot.json")}
  end

  def render("timeslot.json", %{timeslot: timeslot}) do
    %{
      id: timeslot.id,
      activity_name: timeslot.activity_name,
      date: timeslot.date,
      start_time: timeslot.start_time,
      end_time: timeslot.end_time,
      num_max_guests: timeslot.num_max_guests
    }
  end
end
