defmodule AudreyTest do
  use ExUnit.Case, async: true

  import Audrey

  test "parse!/1: does not blow up when parsing an RSS 2.0 compliant XML" do
    xml = File.read!("test/audrey/fixtures/rss2.xml")
    assert parse!(xml)
  end

  test "parse!/1: raises an error when XML is invalid" do
    xml = "not valid"
    assert_raise RuntimeError, fn -> parse!(xml) end
  end

  test "has a channel" do
    {:ok, feed} = File.read!("test/audrey/fixtures/rss2.xml") |> parse
    assert feed.channel
  end
end
