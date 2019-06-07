defmodule Audrey.ChannelTest do
  use ExUnit.Case, async: true

  import Audrey.Channel

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

  test "parse/1: parses the title" do
    channel = channel_xml_basic |> parse
    assert channel.title == "Ember Weekend"
  end

  test "parse/1: parses the link" do
    channel = channel_xml_basic |> parse
    assert channel.link == "https://emberweekend.com/"
  end

  test "parse/1: parses the description" do
    channel = channel_xml_basic |> parse
    assert channel.description == "Ember is a JavaScript framework"
  end

  test "parse/1: parses the image" do
    channel = channel_xml_basic |> parse

    assert channel.image == %Audrey.Image{
             url: "https://emberweekend.com/tomster.png",
             title: "Ember Weekend",
             link: "https://emberweekend.com"
           }
  end
end
