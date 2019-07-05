defmodule Audrey.Item do
  import SweetXml

  alias Audrey.Util

  defstruct [:title, :link, :description, :pub_date]

  def parse(xml) do
    %Audrey.Item{
      title: parse_title(xml),
      link: parse_link(xml),
      description: parse_description(xml),
      pub_date: parse_pub_date(xml)
    }
  end

  defp parse_title(xml) do
    xml |> xpath(~x"./title/text()"s) |> Util.format_value()
  end

  defp parse_link(xml) do
    xml |> xpath(~x"./link/text()"s) |> Util.format_value()
  end

  defp parse_description(xml) do
    xml |> xpath(~x"./description/text()"s) |> Util.format_value()
  end

  defp parse_pub_date(xml) do
    xml |> xpath(~x"./pubDate/text()"s) |> Util.format_value()
  end
end
