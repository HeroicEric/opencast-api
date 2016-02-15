defmodule Audrey.RSS.Channel do
  import SweetXml
  import Audrey.Util, only: [format_value: 1]

  defstruct [:title, :link, :description, items: []]

  def parse(xml) do
    %Audrey.RSS.Channel{
      title: parse_title(xml),
      link: parse_link(xml),
      description: parse_description(xml),
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

  defp parse_items(xml) do
    xml |> xpath(~x"./item"l) |> Enum.map(&Audrey.RSS.Item.parse(&1))
  end
end
