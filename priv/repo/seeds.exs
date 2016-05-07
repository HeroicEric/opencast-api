alias Opencast.Episode
alias Opencast.Podcast
alias Opencast.Repo

defmodule Seeds.Fetcher do
  def fetch_feed(feed_url) do
    case Opencast.Feed.fetch(feed_url) do
      {:ok, feed} -> %{feed: feed, feed_url: feed_url}
      {:error, _msg} -> nil
    end
  end

  def get_podcast(nil), do: nil
  def get_podcast(%{feed: feed, feed_url: feed_url}) do
    podcast = case Repo.get_by(Podcast, %{feed_url: feed_url}) do
      nil -> %Podcast{feed_url: feed_url}
      podcast -> podcast
    end

    {podcast, feed}
  end

  def update_podcast(nil), do: nil
  def update_podcast({podcast, feed}) do
    podcast_params =
      Opencast.Feed.parse_channel(feed)
      # |> Map.put(:feed_url, feed.url)

    changeset = Podcast.changeset(podcast, podcast_params)

    case Repo.insert(changeset) do
      {:ok, podcast} ->
        IO.puts "#{podcast.title} created!"
        {feed, podcast}
      {:error, changeset} ->
        IO.puts "#{podcast.feed_url} could not be created because:"
        IO.inspect changeset.errors
        nil
    end
  end

  def create_episodes(nil) do
    IO.puts "Not fetching because the podcast didn't get created"
  end

  def create_episodes({feed, podcast}) do
    IO.puts("ITS ALIVE!")

    Enum.each feed.items, fn(item) ->
      data =
        Map.take(item, [:title, :description])
        |> Map.put(:url, Map.get(item, :link))
        |> Map.put(:published_at, Ecto.DateTime.utc())

      episode = Ecto.build_assoc(podcast, :episodes)
      changeset = Episode.changeset(episode, data)

      case Repo.insert(changeset) do
        {:ok, episode} ->
          IO.puts "#{episode.title} created!"
        {:error, changeset} ->
          IO.puts "#{data.title} could not be created because:"
          IO.inspect data
          IO.inspect changeset.errors
      end
    end
  end
end

"priv/repo/fixtures/feed_urls.csv"
|> File.stream!
|> Stream.map(&String.strip/1)
|> Stream.map(&Seeds.Fetcher.fetch_feed/1)
|> Stream.map(&Seeds.Fetcher.get_podcast/1)
|> Stream.map(&Seeds.Fetcher.update_podcast/1)
|> Enum.each(&Seeds.Fetcher.create_episodes/1)
