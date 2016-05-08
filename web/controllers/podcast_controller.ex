defmodule Opencast.PodcastController do
  use Opencast.Web, :controller

  import Ecto.Query, only: [from: 2]

  alias Opencast.Episode
  alias Opencast.EpisodeView
  alias Opencast.Podcast

  def index(conn, params) do
    page =
      from(p in Podcast, preload: [:episodes])
      |> Repo.paginate(params)

    render(conn, "index.json", data: page.entries)
  end

  def show(conn, %{"id" => id}) do
    podcast =
      Repo.get!(Podcast, id)
      |> Repo.preload([:episodes, episodes: :podcast])

    render(conn, "show.json", data: podcast)
  end

  def related_episodes(conn, %{"podcast_id" => podcast_id}) do
    episodes =
      Repo.all from e in Episode,
        where: e.podcast_id == ^podcast_id,
        order_by: [desc: :published_at],
        preload: [:podcast]

    render(conn, EpisodeView, "show.json", data: episodes)
  end
end
