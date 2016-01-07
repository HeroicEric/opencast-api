defmodule Opencast.PodcastController do
  use Opencast.Web, :controller

  alias Opencast.Podcast

  def index(conn, _params) do
    podcasts = Repo.all(Podcast)
    render(conn, "index.json", podcasts: podcasts)
  end

  def show(conn, %{"id" => id}) do
    podcast = Repo.get!(Podcast, id)
    render(conn, "show.json", podcast: podcast)
  end
end
