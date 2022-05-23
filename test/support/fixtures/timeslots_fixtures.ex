defmodule Kalendae.TimeslotsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kalendae.Timeslots` context.
  """

  @doc """
  Generate a timeslot.
  """
  def timeslot_fixture(attrs \\ %{}) do
    {:ok, timeslot} =
      attrs
      |> Enum.into(%{
        activity_name: "some activity_name",
        date: ~D[2022-05-22],
        end_time: "some end_time",
        num_max_guests: 42,
        start_time: "some start_time"
      })
      |> Kalendae.Timeslots.create_timeslot()

    timeslot
  end
end
