defmodule Opencast.FeedTest do
  use ExUnit.Case, async: true

  import Opencast.Feed

  def feed do
    %{
      channel: %{
        title: "Ember Weekend",
        link: "https://emberweekend.com",
        description: "Ember is a JavaScript framework",
        image: %{
          url: "https://emberweekend.com/tomster.png"
        },
        items: [
          %{
            title: "Team Tofu Burrito",
            link: "https://emberweekend.com/eps/team-tofu-burrito",
            description: "Put some tofu in your burrito"
          },
          %{
            title: "Global Ember Weekend",
            link: "https://emberweekend.com/eps/global-ember",
            description: "Ember Meetup on the Internet"
          },
          %{
            title: "FastBoot Has a Logo Now",
            link: "https://emberweekend.com/eps/fastboot",
            description: "A cluster of FastBoots is called a stampede"
          }
        ]
      }
    }
  end

  test "parse_channel/1: assigns title from feed channel" do
    podcast = parse_channel(feed)
    assert podcast.title == "Ember Weekend"
  end

  test "parse_channel/1: assigns link from feed channel" do
    podcast = parse_channel(feed)
    assert podcast.link == "https://emberweekend.com"
  end

  test "parse_channel/1: assigns description from feed channel" do
    podcast = parse_channel(feed)
    assert podcast.description == "Ember is a JavaScript framework"
  end

  test "parse_channel/1: assigns image_url from feed channel" do
    podcast = parse_channel(feed)
    assert podcast.image_url == "https://emberweekend.com/tomster.png"
  end

  test "parse_items/1: assigns episode titles from feed items" do
    items = parse_items(feed)
    assert Enum.map(items, &Map.get(&1, :title)) == [
      "Team Tofu Burrito",
      "Global Ember Weekend",
      "FastBoot Has a Logo Now"
    ]
  end

  test "parse_items/1: assigns episode urls from feed items" do
    items = parse_items(feed)
    assert Enum.map(items, &Map.get(&1, :url)) == [
      "https://emberweekend.com/eps/team-tofu-burrito",
      "https://emberweekend.com/eps/global-ember",
      "https://emberweekend.com/eps/fastboot"
    ]
  end

  test "parse_items/1: assigns episode descriptions from feed items" do
    items = parse_items(feed)
    assert Enum.map(items, &Map.get(&1, :description)) == [
      "Put some tofu in your burrito",
      "Ember Meetup on the Internet",
      "A cluster of FastBoots is called a stampede"
    ]
  end
end
