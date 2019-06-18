defmodule Mix.Tasks.FetchEpisodes do
  use Mix.Task

  alias Opencast.Directory

  @shortdoc "Creates episodes for a podcast by id"
  def run([id]) when is_binary(id) do
    Mix.Task.run("app.start")

    podcast = Directory.get_podcast!(id)
    {:ok, feed} = Feeds.fetch_feed(podcast.feed_url)

    Enum.each(feed.items, fn item ->
      IO.inspect(item)
      {:ok, episode} =
        Directory.create_episode(%{
          podcast_id: podcast.id,
          description: item.description,
          link: item.link,
          published_at: Timex.parse!(item.pub_date, "{RFC1123}"),
          title: item.title
        })
      IO.inspect(episode)
    end)
  end
end
