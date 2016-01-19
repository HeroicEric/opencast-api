defmodule Opencast.Router do
  use Opencast.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/api/v1", Opencast do
    pipe_through :api

    resources "/episodes", EpisodeController, only: [:index, :show] do
      get "/podcast", EpisodeController, :related_podcast, as: :related_podcast
    end

    resources "/podcasts", PodcastController, only: [:index, :show] do
      get "/episodes", PodcastController, :related_episodes, as: :related_episodes
    end
  end
end
