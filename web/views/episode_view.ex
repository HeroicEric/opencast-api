defmodule Opencast.EpisodeView do
  use Opencast.Web, :view
  use JaSerializer.PhoenixView

  def type, do: "episodes"

  location :location

  has_one :podcast,
    serializer: Opencast.PodcastView,
    links: [
      related: :related_podcast_link
    ]

  attributes [
    :description,
    :link,
    :published_at,
    :title
  ]

  def location(episode, conn) do
    episode_url(conn, :show, episode)
  end

  def related_podcast_link(episode, conn) do
    episode_related_podcast_url(conn, :related_podcast, episode.id)
  end
end
