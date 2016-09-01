defmodule Opencast.Router do
  use Opencast.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
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

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Opencast do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
