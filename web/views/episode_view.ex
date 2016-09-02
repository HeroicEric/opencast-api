defmodule Opencast.EpisodeView do
  use Opencast.Web, :view
  use JaSerializer.PhoenixView

  def type, do: "episodes"

  location "/api/v1/episodes/:id"

  has_one :podcast,
    serializer: Opencast.PodcastView,
    links: [
      related: "/api/v1/episodes/:id/podcast"
    ]

  attributes [
    :description,
    :link,
    :published_at,
    :title
  ]

  def description(%{description: nil}, _), do: nil
  def description(%{description: description}, _) do
    HtmlSanitizeEx.basic_html(description)
  end
end
