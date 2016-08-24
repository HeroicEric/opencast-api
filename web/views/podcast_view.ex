defmodule Opencast.PodcastView do
  use Opencast.Web, :view
  use JaSerializer.PhoenixView

  def type, do: "podcasts"

  location :location

  has_many :episodes,
    serializer: Opencast.EpisodeView,
    links: [
      related: :related_episodes_link
    ],
    include: true

  attributes [
    :feed_url,
    :image_url,
    :link,
    :description,
    :title
  ]

  def location(podcast, conn) do
    podcast_url(conn, :show, podcast)
  end

  def related_episodes_link(podcast, conn) do
    podcast_related_episodes_url(conn, :related_episodes, podcast.id)
  end
end
