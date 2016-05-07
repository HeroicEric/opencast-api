defmodule Opencast.Feed do
  defstruct [:podcast]

  def fetch(url) do
    Audrey.fetch(url)
  end

  def parse_channel(%{channel: channel}) do
    %{
      title: channel.title,
      link: channel.link,
      description: channel.description,
      image_url: parse_image_url(channel)
    }
  end

  def parse_items(%{channel: %{items: items}}) do
    Enum.map(items, &parse_item/1)
  end

  defp parse_item(item) do
    %{
      title: item.title,
      url: item.link,
      description: item.description
    }
  end

  defp parse_image_url(%{image: image}) do
    case image do
      nil -> nil
      image -> Map.get(image, :url)
    end
  end
end
