defmodule Opencast.PodcastResource do
  import JSONAPI.ResourceObject

  @attributes [
    :title,
    :description,
    :feed_url,
    :image_url,
    :link
  ]

  def format(data, context) do
    build
    |> put_top_level(%{type: "podcasts", id: data.id})
    |> put_attributes(data, @attributes)
    |> put_has_many(data, :episodes)
  end
end
