defmodule Opencast.PodcastSerializer do
  use JSONAPI.Serializer

  def type, do: "podcasts"

  def links(model) do
    %{self: "/api/v1/podcasts/" <> to_string(model.id)}
  end

  def attributes do
    [
      :feed_url,
      :image_url,
      :link,
      :description,
      :title
    ]
  end

  def relationships do
    [
      %{name: :episodes, cardinality: :many},
      %{name: :author, cardinality: :one}
    ]
  end
end
