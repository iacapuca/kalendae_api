defmodule KalendaeWeb.TimeslotView do
  use JSONAPI.View, type: "timeslots"

  def fields do
    [:id, :activity_name, :date, :start_time, :end_time, :num_max_guests]
  end
end
