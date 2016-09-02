defmodule Opencast.PodcastView do
  use Opencast.Web, :view
  use JaSerializer.PhoenixView

  def type, do: "podcasts"

  location "/api/v1/podcasts/:id"

  has_many :episodes,
    serializer: Opencast.EpisodeView,
    links: [
      related: "/api/v1/podcasts/:id/episodes"
    ]

  attributes [
    :feed_url,
    :image_url,
    :link,
    :description,
    :title
  ]
end
