defmodule Audrey.Channel do
  import SweetXml

  alias Audrey.Util

  defstruct [:title, :link, :description, :image]

  def parse(xml) do
    %Audrey.Channel{
      title: parse_title(xml),
      link: parse_link(xml),
      description: parse_description(xml),
      image: parse_image(xml)
    }
  end

  defp parse_title(xml) do
    xml |> xpath(~x"./title/text()"s)
  end

  defp parse_link(xml) do
    xml |> xpath(~x"./link/text()"s) |> Util.format_value()
  end

  defp parse_description(xml) do
    xml |> xpath(~x"./description/text()"s) |> Util.format_value()
  end

  defp parse_image(xml) do
    xml |> xpath(~x"./image") |> Audrey.Image.parse()
  end
end
