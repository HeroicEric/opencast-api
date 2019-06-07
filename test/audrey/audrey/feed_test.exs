defmodule Audrey.RSS.FeedTest do
  use ExUnit.Case, async: true

  import Audrey.Feed

  def feed_xml_basic do
    """
    <rss>
      <channel>
        <title>Ember Weekend</title>
        <item><title>Ember</title></item>
        <item><title>Angular</title></item>
        <item><title>React</title></item>
      </channel>
    </rss>
    """
  end

  test "parse/1: parses the channel" do
    result = feed_xml_basic() |> parse()
    assert result.channel == %Audrey.Channel{title: "Ember Weekend"}
  end

  test "parse/1: parses the items" do
    result = feed_xml_basic() |> parse()

    assert result.items == [
             %Audrey.Item{title: "Ember"},
             %Audrey.Item{title: "Angular"},
             %Audrey.Item{title: "React"}
           ]
  end
end
