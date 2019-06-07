defmodule OpencastWeb.Router do
  use OpencastWeb, :router

  pipeline :api_v1 do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", OpencastWeb.API.V1, as: :api_v1 do
    pipe_through :api_v1

    resources "/episodes", EpisodeController, only: [:index, :show] do
      get "/podcast", EpisodeController, :related_podcast, as: :related_podcast
    end

    resources "/podcasts", PodcastController, only: [:index, :show] do
      get "/episodes", PodcastController, :related_episodes, as: :related_episodes
    end
  end
end
