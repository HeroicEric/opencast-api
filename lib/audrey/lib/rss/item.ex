defmodule Audrey.RSS.Item do
  import SweetXml
  import Audrey.Util, only: [format_value: 1]

  defstruct [:title, :link, :description, :pub_date]

  def parse(xml) do
    %Audrey.RSS.Item{
      title: parse_title(xml),
      link: parse_link(xml),
      description: parse_description(xml),
      pub_date: parse_pub_date(xml)
    }
  end

  defp parse_title(xml) do
    xml |> xpath(~x"./title/text()"s) |> format_value
  end

  defp parse_link(xml) do
    xml |> xpath(~x"./link/text()"s) |> format_value
  end

  defp parse_description(xml) do
    xml |> xpath(~x"./description/text()"s) |> format_value
  end

  defp parse_pub_date(xml) do
    xml |> xpath(~x"./pubDate/text()"s) |> format_value
  end
end
