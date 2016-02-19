defmodule Opencast.PodcastView do
  use Opencast.Web, :view

  def render("index.json", %{conn: conn, data: podcasts}) do
    resources = Enum.map(podcasts, fn(podcast) ->
      Opencast.PodcastResource.format(podcast, %{conn: conn})
    end)

    JSONAPI.Document.build
    |> JSONAPI.Document.put_primary_data(resources)
    |> Map.put(:links, %{self: podcast_url(conn, :index)})
  end

  def render("show.json", %{conn: conn, data: podcast}) do
    resource = Opencast.PodcastResource.format(podcast, %{conn: conn, derp: "asdasd"})

    JSONAPI.Document.build
    |> JSONAPI.Document.put_primary_data(resource)
    |> Map.put(:links, %{self: podcast_url(conn, :show, podcast.id)})
  end
end
