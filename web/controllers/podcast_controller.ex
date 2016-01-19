defmodule Opencast.PodcastController do
  use Opencast.Web, :controller

  alias Opencast.Episode
  alias Opencast.EpisodeView
  alias Opencast.Podcast

  def index(conn, _params) do
    podcasts = Repo.all(Podcast) |> Repo.preload(:episodes)
    render(conn, "index.json", podcasts: podcasts)
  end

  def show(conn, %{"id" => id}) do
    podcast =
      Repo.get!(Podcast, id)
      |> Repo.preload([:episodes, episodes: :podcast])

    render(conn, "show.json", podcast: podcast)
  end

  def related_episodes(conn, %{"podcast_id" => podcast_id}) do
    episodes =
      Repo.all from e in Episode,
        where: e.podcast_id == ^podcast_id,
        order_by: [desc: :published_at],
        preload: [:podcast]

    render(conn, EpisodeView, "show.json", episodes: episodes)
  end
end
