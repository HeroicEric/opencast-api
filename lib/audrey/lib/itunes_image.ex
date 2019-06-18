defmodule Audrey.ITunesImage do
  import SweetXml
  import Audrey.Util, only: [format_value: 1]

  defstruct [:url, :title, :link]

  def parse(nil), do: nil

  def parse(xml) do
    %Audrey.Image{url: parse_url(xml)}
  end

  defp parse_url(xml) do
    xml |> xpath(~x"./@href"s) |> format_value
  end
end
