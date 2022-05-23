defmodule Kalendae.TimeslotsTest do
  use Kalendae.DataCase

  alias Kalendae.Timeslots

  describe "timeslots" do
    alias Kalendae.Timeslots.Timeslot

    import Kalendae.TimeslotsFixtures

    @invalid_attrs %{activity_name: nil, date: nil, end_time: nil, num_max_guests: nil, start_time: nil}

    test "list_timeslots/0 returns all timeslots" do
      timeslot = timeslot_fixture()
      assert Timeslots.list_timeslots() == [timeslot]
    end

    test "get_timeslot!/1 returns the timeslot with given id" do
      timeslot = timeslot_fixture()
      assert Timeslots.get_timeslot!(timeslot.id) == timeslot
    end

    test "create_timeslot/1 with valid data creates a timeslot" do
      valid_attrs = %{activity_name: "some activity_name", date: ~D[2022-05-22], end_time: "some end_time", num_max_guests: 42, start_time: "some start_time"}

      assert {:ok, %Timeslot{} = timeslot} = Timeslots.create_timeslot(valid_attrs)
      assert timeslot.activity_name == "some activity_name"
      assert timeslot.date == ~D[2022-05-22]
      assert timeslot.end_time == "some end_time"
      assert timeslot.num_max_guests == 42
      assert timeslot.start_time == "some start_time"
    end

    test "create_timeslot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeslots.create_timeslot(@invalid_attrs)
    end

    test "update_timeslot/2 with valid data updates the timeslot" do
      timeslot = timeslot_fixture()
      update_attrs = %{activity_name: "some updated activity_name", date: ~D[2022-05-23], end_time: "some updated end_time", num_max_guests: 43, start_time: "some updated start_time"}

      assert {:ok, %Timeslot{} = timeslot} = Timeslots.update_timeslot(timeslot, update_attrs)
      assert timeslot.activity_name == "some updated activity_name"
      assert timeslot.date == ~D[2022-05-23]
      assert timeslot.end_time == "some updated end_time"
      assert timeslot.num_max_guests == 43
      assert timeslot.start_time == "some updated start_time"
    end

    test "update_timeslot/2 with invalid data returns error changeset" do
      timeslot = timeslot_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeslots.update_timeslot(timeslot, @invalid_attrs)
      assert timeslot == Timeslots.get_timeslot!(timeslot.id)
    end

    test "delete_timeslot/1 deletes the timeslot" do
      timeslot = timeslot_fixture()
      assert {:ok, %Timeslot{}} = Timeslots.delete_timeslot(timeslot)
      assert_raise Ecto.NoResultsError, fn -> Timeslots.get_timeslot!(timeslot.id) end
    end

    test "change_timeslot/1 returns a timeslot changeset" do
      timeslot = timeslot_fixture()
      assert %Ecto.Changeset{} = Timeslots.change_timeslot(timeslot)
    end
  end
end
