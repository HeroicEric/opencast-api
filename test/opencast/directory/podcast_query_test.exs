defmodule Opencast.Directory.PodcastQueryTest do
  use Opencast.DataCase

  alias Opencast.Directory.Podcast
  alias Opencast.Directory.PodcastQuery
  alias Opencast.Factory

  test "filter/2: returns original query when no filters are present" do
    soup = Factory.insert(:podcast, %{title: "Soup"})
    bear = Factory.insert(:podcast, %{title: "Bear"})
    params = %{}

    result = Podcast |> PodcastQuery.filter(params) |> Repo.all()

    assert result == [soup, bear]
  end

  test "filter/2: filters by title" do
    soup = Factory.insert(:podcast, %{title: "Soup"})
    _bear = Factory.insert(:podcast, %{title: "Bear"})
    params = %{"filter" => %{"query" => "Soup"}}

    result = Podcast |> PodcastQuery.filter(params) |> Repo.all()

    assert result == [soup]
  end

  test "filter/2: is case-insensitive" do
    _soup = Factory.insert(:podcast, %{title: "Soup"})
    bear = Factory.insert(:podcast, %{title: "Bear"})
    params = %{"filter" => %{"query" => "bear"}}

    result = Podcast |> PodcastQuery.filter(params) |> Repo.all()

    assert result == [bear]
  end

  test "filter/2: is matches anywhere inside the title string" do
    _soup = Factory.insert(:podcast, %{title: "Something Soup Duh"})
    bear = Factory.insert(:podcast, %{title: "Bear Cat Meow"})
    params = %{"filter" => %{"query" => "Cat"}}

    result = Podcast |> PodcastQuery.filter(params) |> Repo.all()

    assert result == [bear]
  end
end
