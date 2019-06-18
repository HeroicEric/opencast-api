defmodule Feeds do
  @headers "application/rss+xml, application/rdf+xml;q=0.8, application/atom+xml;q=0.6, application/xml;q=0.4, text/xml;q=0.4"

  def fetch_feed(url) do
    {:ok, response} =
      Tesla.get(url, headers: [
        {"content-type", "application/rss+xml"},
        {"accept", @headers}
      ])

    Audrey.parse(response.body)
  end
end
