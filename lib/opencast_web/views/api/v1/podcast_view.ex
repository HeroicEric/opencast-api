defmodule OpencastWeb.API.V1.PodcastView do
  use OpencastWeb, :view
  use JaSerializer.PhoenixView

  def type, do: "podcasts"

  location("/api/v1/podcasts/:id")

  has_many :episodes,
    serializer: OpencastWeb.API.V1.EpisodeView,
    links: [
      related: "/api/v1/podcasts/:id/episodes"
    ]

  attributes([
    :feed_url,
    :image_url,
    :link,
    :description,
    :title
  ])
end
