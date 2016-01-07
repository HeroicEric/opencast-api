defmodule Opencast.PodcastView do
  use Opencast.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :feed_url,
    :image_url,
    :link,
    :description,
    :title
  ]
end
