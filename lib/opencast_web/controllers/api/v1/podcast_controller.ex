defmodule OpencastWeb.API.V1.PodcastController do
  use OpencastWeb, :controller

  import Ecto.Query, only: [from: 2]

  alias Opencast.Directory.Episode
  alias Opencast.Directory.Podcast
  alias Opencast.Repo
  alias OpencastWeb.API.V1.EpisodeView

  action_fallback OpencastWeb.FallbackController

  def index(conn, params) do
    podcasts =
      Podcast
      |> Opencast.Directory.PodcastQuery.filter(params)
      |> Repo.paginate(%{
        page: get_in(params, ["page", "number"]),
        page_size: get_in(params, ["page", "size"])
      })

    render(conn, "index.json-api", data: podcasts)
  end

  def show(conn, %{"id" => id}) do
    podcast = Repo.get!(Podcast, id)

    render(conn, "show.json-api", data: podcast)
  end

  def related_episodes(conn, %{"podcast_id" => podcast_id}) do
    episodes =
      Repo.all(
        from e in Episode,
          where: e.podcast_id == ^podcast_id,
          order_by: [desc: :published_at],
          preload: [:podcast]
      )

    render(conn, EpisodeView, "index.json-api", data: episodes)
  end
end
