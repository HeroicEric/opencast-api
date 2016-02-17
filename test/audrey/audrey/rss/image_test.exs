defmodule Audrey.RSS.ImageTest do
  use ExUnit.Case, async: true

  import Audrey.RSS.Image

  def image_xml_basic do
    """
    <image>
      <url>https://emberweekend.com/tomster.png</url>
      <title>Ember Weekend</title>
      <link>https://emberweekend.com</link>
    </image>
    """
  end

  test "parses the title" do
    channel = image_xml_basic |> parse
    assert channel.title == "Ember Weekend"
  end

  test "parses the url " do
    channel = image_xml_basic |> parse
    assert channel.url == "https://emberweekend.com/tomster.png"
  end

  test "parses the link" do
    channel = image_xml_basic |> parse
    assert channel.link == "https://emberweekend.com"
  end
end
