defmodule Opencast.Repo do
  use Ecto.Repo, otp_app: :opencast
  use Scrivener, page_size: 20
end
