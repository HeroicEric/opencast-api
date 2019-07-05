defmodule Audrey.RSS.FeedTest do
  use ExUnit.Case, async: true

  alias Audrey.Channel
  alias Audrey.Feed

  @feed_xml_basic """
    <rss>
      <channel>
        <title>Ember Weekend</title>
        <item><title>Ember</title></item>
        <item><title>Angular</title></item>
        <item><title>React</title></item>
      </channel>
    </rss>
  """

  test "parse/1: parses the channel" do
    %Feed{channel: %Channel{} = channel} = Feed.parse(@feed_xml_basic)
    assert channel.title == "Ember Weekend"
  end

  test "parse/1: parses the items" do
    %Feed{items: items} = Feed.parse(@feed_xml_basic)

    assert items == [
             %Audrey.Item{title: "Ember"},
             %Audrey.Item{title: "Angular"},
             %Audrey.Item{title: "React"}
           ]
  end
end
