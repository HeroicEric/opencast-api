defmodule Audrey.Image do
  import SweetXml

  alias Audrey.Util

  defstruct [:url, :title, :link]

  def parse(nil), do: nil

  def parse(xml) do
    %Audrey.Image{
      url: parse_url(xml),
      title: parse_title(xml),
      link: parse_link(xml)
    }
  end

  defp parse_url(xml) do
    xml |> xpath(~x"./url/text()"s) |> Util.format_value()
  end

  defp parse_title(xml) do
    xml |> xpath(~x"./title/text()"s) |> Util.format_value()
  end

  defp parse_link(xml) do
    xml |> xpath(~x"./link/text()"s) |> Util.format_value()
  end
end
