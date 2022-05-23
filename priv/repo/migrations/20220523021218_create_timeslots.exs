defmodule Kalendae.Repo.Migrations.CreateTimeslots do
  use Ecto.Migration

  def change do
    create table(:timeslots) do
      add :activity_name, :string
      add :date, :date
      add :start_time, :string
      add :end_time, :string
      add :num_max_guests, :integer

      timestamps()
    end
  end
end
