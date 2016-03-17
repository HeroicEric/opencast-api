defmodule Audrey.Feed do
  import SweetXml

  defstruct [:channel]

  def parse(xml) do
    %Audrey.Feed{channel: parse_channel(xml)}
  end

  defp parse_channel(xml) do
    xml |> xpath(~x"//channel") |> Audrey.Channel.parse
  end
end
