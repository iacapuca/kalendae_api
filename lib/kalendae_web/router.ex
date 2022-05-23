defmodule KalendaeWeb.Router do
  use KalendaeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KalendaeWeb do
    pipe_through :api
    resources "/timeslots", TimeslotController, except: [:new, :edit]
  end
end
