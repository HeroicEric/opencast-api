defmodule Opencast.EpisodeController do
  use Opencast.Web, :controller

  alias Opencast.Episode
  alias Opencast.PodcastView

  def index(conn, _params) do
    episodes = Repo.all(from e in Episode, preload: [:podcast])
    render(conn, "index.json", data: episodes)
  end

  def show(conn, %{"id" => id}) do
    episode = Repo.get!(Episode, id) |> Repo.preload(:podcast)
    render(conn, "show.json", data: episode)
  end

  def related_podcast(conn, %{"episode_id" => episode_id}) do
    episode =
      Repo.get!(Episode, episode_id)
      |> Repo.preload([:podcast, podcast: :episodes])

    render(conn, PodcastView, "show.json", data: episode.podcast)
  end
end
