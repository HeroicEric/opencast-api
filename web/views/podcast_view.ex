defmodule Opencast.PodcastView do
  use Opencast.Web, :view

  alias Opencast.PodcastSerializer

  def render("index.json", %{podcasts: podcasts}) do
    PodcastSerializer.serialize(podcasts, %{include: "episodes"})
  end

  def render("show.json", %{podcast: podcast}) do
    PodcastSerializer.serialize(podcast)
  end
end
