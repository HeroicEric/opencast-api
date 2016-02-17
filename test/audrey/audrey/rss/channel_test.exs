defmodule Audrey.RSS.ChannelTest do
  use ExUnit.Case, async: true

  import Audrey.RSS.Channel

  def channel_xml_basic do
    """
    <channel>
      <title>Ember Weekend</title>
      <link>https://emberweekend.com/</link>
      <description>Ember is a JavaScript framework</description>
      <image>
        <url>https://emberweekend.com/tomster.png</url>
        <title>Ember Weekend</title>
        <link>https://emberweekend.com</link>
      </image>
      <item><title>Ember</title></item>
      <item><title>Angular</title></item>
      <item><title>React</title></item>
    </channel>
    """
  end

  test "parses the title" do
    channel = channel_xml_basic |> parse
    assert channel.title == "Ember Weekend"
  end

  test "parses the link" do
    channel = channel_xml_basic |> parse
    assert channel.link == "https://emberweekend.com/"
  end

  test "parses the description" do
    channel = channel_xml_basic |> parse
    assert channel.description == "Ember is a JavaScript framework"
  end

  test "parses the image" do
    channel = channel_xml_basic |> parse
    assert channel.image == %Audrey.RSS.Image{
      url: "https://emberweekend.com/tomster.png",
      title: "Ember Weekend",
      link: "https://emberweekend.com"
    }
  end

  test "parses items" do
    channel = channel_xml_basic |> parse
    item_titles = Enum.map(channel.items, &Map.get(&1, :title))

    assert item_titles == ["Ember", "Angular", "React"]
  end
end
