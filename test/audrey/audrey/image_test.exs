defmodule Audrey.ImageTest do
  use ExUnit.Case, async: true

  alias Audrey.Image

  @image_xml_basic """
    <image>
      <url>https://emberweekend.com/tomster.png</url>
      <title>Ember Weekend</title>
      <link>https://emberweekend.com</link>
    </image>
  """

  test "parses the title" do
    %Image{title: title} = Image.parse(@image_xml_basic)
    assert title == "Ember Weekend"
  end

  test "parses the url " do
    %Image{url: url} = Image.parse(@image_xml_basic)
    assert url == "https://emberweekend.com/tomster.png"
  end

  test "parses the link" do
    %Image{link: link} = Image.parse(@image_xml_basic)
    assert link == "https://emberweekend.com"
  end
end
