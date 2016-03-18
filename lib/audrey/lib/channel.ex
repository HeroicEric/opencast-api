defmodule Audrey.Channel do
  import SweetXml
  import Audrey.Util, only: [format_value: 1]

  defstruct [:title, :link, :description, :image, items: []]

  def parse(xml) do
    %Audrey.Channel{
      title: parse_title(xml),
      link: parse_link(xml),
      description: parse_description(xml),
      image: parse_image(xml),
      items: parse_items(xml)
    }
  end

  defp parse_title(xml) do
    xml |> xpath(~x"./title/text()"s)
  end

  defp parse_link(xml) do
    xml |> xpath(~x"./link/text()"s) |> format_value
  end

  defp parse_description(xml) do
    xml |> xpath(~x"./description/text()"s) |> format_value
  end

  defp parse_image(xml) do
    xml |> xpath(~x"./image") |> Audrey.Image.parse
  end

  defp parse_items(xml) do
    xml |> xpath(~x"./item"l) |> Enum.map(&Audrey.Item.parse(&1))
  end
end
