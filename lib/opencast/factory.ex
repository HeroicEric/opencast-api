defmodule Opencast.Factory do
  use ExMachina.Ecto, repo: Opencast.Repo

  alias Opencast.Episode
  alias Opencast.Podcast

  def factory(:episode) do
    %Episode{
      podcast: build(:podcast),
      published_at: Ecto.DateTime.utc(),
      url: sequence(:feed_url, &"http://example#{&1}.com/rss"),
      title: sequence(:title, &"Awesome Episode ##{&1}")
    }
  end

  def factory(:podcast) do
    %Podcast{
      description: sequence(:description, &"This podcast is really awesome##{&1}"),
      feed_url: sequence(:feed_url, &"http://example#{&1}.com/rss"),
      link: sequence(:link, &"http://example#{&1}.com"),
      title: sequence(:title, &"Awesome Podcast ##{&1}")
    }
  end
end
