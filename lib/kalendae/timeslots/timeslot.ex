defmodule Kalendae.Timeslots.Timeslot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timeslots" do
    field :activity_name, :string
    field :date, :date
    field :end_time, :string
    field :num_max_guests, :integer
    field :start_time, :string

    timestamps()
  end

  @doc false
  def changeset(timeslot, attrs) do
    timeslot
    |> cast(attrs, [:activity_name, :date, :start_time, :end_time, :num_max_guests])
    |> validate_required([:activity_name, :date, :start_time, :end_time, :num_max_guests])
  end
end
