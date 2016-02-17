defmodule Audrey.RSS.Image do
  import SweetXml
  import Audrey.Util, only: [format_value: 1]

  defstruct [:url, :title, :link]

  def parse(nil), do: %Audrey.RSS.Image{}

  def parse(xml) do
    %Audrey.RSS.Image{
      url: parse_url(xml),
      title: parse_title(xml),
      link: parse_link(xml)
    }
  end

  defp parse_url(xml) do
    xml |> xpath(~x"./url/text()"s) |> format_value
  end

  defp parse_title(xml) do
    xml |> xpath(~x"./title/text()"s) |> format_value
  end

  defp parse_link(xml) do
    xml |> xpath(~x"./link/text()"s) |> format_value
  end
end
