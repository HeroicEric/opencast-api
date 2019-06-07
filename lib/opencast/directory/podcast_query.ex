defmodule Opencast.Directory.PodcastQuery do
  import Ecto.Query, only: [from: 2]

  def filter(query, %{"filter" => %{"query" => query_string}}) do
    from p in query, where: ilike(p.title, ^"%#{query_string}%")
  end

  def filter(query, _), do: query
end
