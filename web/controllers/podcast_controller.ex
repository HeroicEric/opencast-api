defmodule Opencast.PodcastController do
  use Opencast.Web, :controller

  import Ecto.Query, only: [from: 2]

  alias Opencast.Episode
  alias Opencast.EpisodeView
  alias Opencast.Podcast

  def index(conn, params) do
    podcasts =
      from(p in Podcast, preload: [:episodes, episodes: [:podcast]])
      |> Opencast.PodcastQuery.filter(params)
      |> Repo.paginate(Map.get(params, "page", %{}))

    render(conn, "index.json-api", data: podcasts)
  end

  def show(conn, %{"id" => id}) do
    podcast =
      Repo.get!(Podcast, id)
      |> Repo.preload([:episodes, episodes: :podcast])

    render(conn, "show.json-api", data: podcast)
  end

  def related_episodes(conn, %{"podcast_id" => podcast_id}) do
    episodes =
      Repo.all from e in Episode,
        where: e.podcast_id == ^podcast_id,
        order_by: [desc: :published_at],
        preload: [:podcast]

    render(conn, EpisodeView, "show.json-api", data: episodes)
  end
end
