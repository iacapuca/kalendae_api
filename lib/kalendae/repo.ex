defmodule Kalendae.Repo do
  use Ecto.Repo,
    otp_app: :kalendae,
    adapter: Ecto.Adapters.Postgres
end
