defmodule Opencast.Repo do
  use Ecto.Repo,
    otp_app: :opencast,
    adapter: Ecto.Adapters.Postgres

  use Scrivener
end
