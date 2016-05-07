defmodule Opencast.EpisodeController do
  use Opencast.Web, :controller

  import Ecto.Query, only: [from: 2]

  alias Opencast.Episode
  alias Opencast.PodcastView

  def index(conn, params) do
    page =
      from(e in Episode, preload: [:podcast])
      |> Repo.paginate(params)

    render(conn, "index.json", data: page.entries)
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
