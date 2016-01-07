defmodule Opencast.Factory do
  use ExMachina.Ecto, repo: Opencast.Repo

  alias Opencast.Podcast

  def factory(:podcast) do
    %Podcast{
      description: sequence(:description, &"This podcast is really awesome##{&1}"),
      feed_url: sequence(:feed_url, &"http://example#{&1}.com/rss"),
      link: sequence(:link, &"http://example#{&1}.com"),
      title: sequence(:title, &"Awesome Podcast ##{&1}")
    }
  end
end
