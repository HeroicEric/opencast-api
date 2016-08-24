defmodule Opencast.PodcastQueryTest do
  use Opencast.ModelCase

  import Opencast.Factory

  alias Opencast.Podcast
  alias Opencast.PodcastQuery

  test "filter/2: returns original query when no filters are present" do
    soup = insert(:podcast, %{title: "Soup"})
    bear = insert(:podcast, %{title: "Bear"})
    params = %{}

    result = Podcast |> PodcastQuery.filter(params) |> Repo.all

    assert result == [soup, bear]
  end

  test "filter/2: filters by title" do
    soup = insert(:podcast, %{title: "Soup"})
    _bear = insert(:podcast, %{title: "Bear"})
    params = %{"filter" => %{"query" => "Soup"}}

    result = Podcast |> PodcastQuery.filter(params) |> Repo.all

    assert result == [soup]
  end

  test "filter/2: is case-insensitive" do
    _soup = insert(:podcast, %{title: "Soup"})
    bear = insert(:podcast, %{title: "Bear"})
    params = %{"filter" => %{"query" => "bear"}}

    result = Podcast |> PodcastQuery.filter(params) |> Repo.all

    assert result == [bear]
  end

  test "filter/2: is matches anywhere inside the title string" do
    _soup = insert(:podcast, %{title: "Something Soup Duh"})
    bear = insert(:podcast, %{title: "Bear Cat Meow"})
    params = %{"filter" => %{"query" => "Cat"}}

    result = Podcast |> PodcastQuery.filter(params) |> Repo.all

    assert result == [bear]
  end
end
