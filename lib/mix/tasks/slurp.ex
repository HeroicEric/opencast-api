defmodule Mix.Tasks.Slurp do
  use Mix.Task

  @shortdoc "Slurps in a podcast"
  def run([url]) when is_binary(url) do
    Mix.Task.run("app.start")

    {:ok, feed} = Feeds.fetch_feed(url)

    case create_podcast(url, feed) do
      {:ok, podcast} ->
        IO.puts("Podcast created")
        IO.inspect(podcast)
      {:error, error} ->
        IO.inspect(error)
    end
  end

  defp create_podcast(url, feed) do
    Opencast.Directory.create_podcast(%{
      description: feed.channel.description,
      feed_url: url,
      image_url: get_image_url(feed),
      link: feed.channel.link,
      title: feed.channel.title
    })
  end

  defp get_image_url(%{channel: %{itunes_image: %{url: url}}}), do: url
  defp get_image_url(%{channel: %{image: %{url: url}}}), do: url
  defp get_image_url(_), do: nil
end
