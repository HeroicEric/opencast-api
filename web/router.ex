defmodule Opencast.Router do
  use Opencast.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Opencast do
    pipe_through :api
  end
end
