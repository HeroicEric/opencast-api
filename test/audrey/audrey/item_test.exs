defmodule Audrey.ItemTest do
  use ExUnit.Case, async: true

  alias Audrey.Item

  @item_xml_basic """
    <item>
      <title>Star City</title>
      <link>http://liftoff.msfc.nasa.gov/news/news-starcity.asp</link>
      <description>How do Americans even?</description>
      <pubDate>Tue, 03 Jun 2003 09:39:21 GMT</pubDate>
    </item>
  """

  test "parses the title" do
    %Item{title: title} = Item.parse(@item_xml_basic)
    assert title == "Star City"
  end

  test "parses the link" do
    %Item{link: link} = Item.parse(@item_xml_basic)
    assert link == "http://liftoff.msfc.nasa.gov/news/news-starcity.asp"
  end

  test "parses the description" do
    %Item{description: description} = Item.parse(@item_xml_basic)
    assert description == "How do Americans even?"
  end

  test "parses the pubDate" do
    %Item{pub_date: pub_date} = Item.parse(@item_xml_basic)
    assert pub_date == "Tue, 03 Jun 2003 09:39:21 GMT"
  end
end
