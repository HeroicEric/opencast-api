defmodule OpencastWeb.API.V1.EpisodeController do
  use OpencastWeb, :controller

  import Ecto.Query, only: [from: 2]

  alias Opencast.Directory.Episode
  alias Opencast.Directory.Podcast
  alias Opencast.Repo
  alias OpencastWeb.API.V1.PodcastView

  action_fallback OpencastWeb.FallbackController

  def index(conn, params) do
    episodes =
      from(e in Episode, preload: [:podcast])
      |> Repo.paginate(%{
        page: get_in(params, ["page", "number"]),
        page_size: get_in(params, ["page", "size"])
      })

    render(conn, "index.json-api", data: episodes)
  end

  def show(conn, %{"id" => id}) do
    episode = Repo.get!(Episode, id) |> Repo.preload(:podcast)
    render(conn, "show.json-api", data: episode)
  end

  def related_podcast(conn, %{"episode_id" => episode_id}) do
    episode = Repo.get!(Episode, episode_id)

    podcast =
      from(p in Podcast,
        where: p.id == ^episode.podcast_id,
        preload: [:episodes, episodes: :podcast]
      )
      |> Repo.one()

    conn
    |> put_view(PodcastView)
    |> render("show.json-api", data: podcast)
  end
end
