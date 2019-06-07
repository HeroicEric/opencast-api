defmodule OpencastWeb.API.V1.EpisodeView do
  use OpencastWeb, :view
  use JaSerializer.PhoenixView

  def type, do: "episodes"

  location("/api/v1/episodes/:id")

  has_one :podcast,
    serializer: OpencastWeb.API.V1.PodcastView,
    links: [
      related: "/api/v1/episodes/:id/podcast"
    ]

  attributes([
    :description,
    :link,
    :published_at,
    :title
  ])

  def description(%{description: nil}, _), do: nil

  def description(%{description: description}, _) do
    HtmlSanitizeEx.basic_html(description)
  end
end
