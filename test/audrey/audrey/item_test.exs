defmodule Audrey.ItemTest do
  use ExUnit.Case, async: true

  import Audrey.Item

  def item_xml_basic do
    """
    <item>
      <title>Star City</title>
      <link>http://liftoff.msfc.nasa.gov/news/news-starcity.asp</link>
      <description>How do Americans even?</description>
      <pubDate>Tue, 03 Jun 2003 09:39:21 GMT</pubDate>
    </item>
    """
  end

  test "parses the title" do
    item = item_xml_basic |> parse
    assert item.title == "Star City"
  end

  test "parses the link" do
    item = item_xml_basic |> parse
    assert item.link == "http://liftoff.msfc.nasa.gov/news/news-starcity.asp"
  end

  test "parses the description" do
    item = item_xml_basic |> parse
    assert item.description == "How do Americans even?"
  end

  test "parses the pubDate" do
    item = item_xml_basic |> parse
    assert item.pub_date == "Tue, 03 Jun 2003 09:39:21 GMT"
  end
end
