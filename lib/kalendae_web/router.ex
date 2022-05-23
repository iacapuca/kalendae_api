defmodule KalendaeWeb.Router do
  use KalendaeWeb, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JSONAPI.Deserializer
    plug JSONAPI.UnderscoreParameters
  end

  scope "/api", KalendaeWeb do
    pipe_through :api
    resources "/timeslots", TimeslotController
  end
end
