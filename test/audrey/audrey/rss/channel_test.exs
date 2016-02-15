defmodule Audrey.RSS.ChannelTest do
  use ExUnit.Case, async: true

  import Audrey.RSS.Channel

  def channel_xml_basic do
    """
    <channel>
      <title>JavaScript Fatigue</title>
      <link>http://jsfatigue.com/</link>
      <description>Too many tools. Too little time.</description>
      <item><title>Ember</title></item>
      <item><title>Angular</title></item>
      <item><title>React</title></item>
    </channel>
    """
  end

  test "parses the title" do
    channel = channel_xml_basic |> parse
    assert channel.title == "JavaScript Fatigue"
  end

  test "parses the link" do
    channel = channel_xml_basic |> parse
    assert channel.link == "http://jsfatigue.com/"
  end

  test "parses the description" do
    channel = channel_xml_basic |> parse
    assert channel.description == "Too many tools. Too little time."
  end

  test "parses items" do
    channel = channel_xml_basic |> parse
    item_titles = Enum.map(channel.items, &Map.get(&1, :title))

    assert item_titles == ["Ember", "Angular", "React"]
  end
end
