defmodule Opencast.Router do
  use Opencast.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/api/v1", Opencast do
    pipe_through :api

    resources "/podcasts", PodcastController, only: [:index, :show]
  end
end
