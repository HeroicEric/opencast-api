defmodule Audrey.Feed do
  import SweetXml, except: [parse: 1]

  defstruct [:channel, items: []]

  def parse(xml) do
    %Audrey.Feed{
      channel: parse_channel(xml),
      items: parse_items(xml)
    }
  end

  defp parse_channel(xml) do
    xml |> xpath(~x"//channel") |> Audrey.Channel.parse
  end

  defp parse_items(xml) do
    xml |> xpath(~x"//item"l) |> Enum.map(&Audrey.Item.parse(&1))
  end
end
