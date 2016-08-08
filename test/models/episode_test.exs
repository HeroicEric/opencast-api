defmodule Opencast.EpisodeTest do
  use Opencast.ModelCase

  alias Opencast.Episode
  alias Opencast.Factory

  @valid_attrs %{
    podcast_id: "6add86ec-187a-4b8a-ba8d-9208c2fb9cdf",
    published_at: "2016-01-19 03:52:44Z",
    title: "Some Episode",
    url: "http://example.com"
  }

  test "changeset with valid attributes" do
    changeset = Episode.changeset(%Episode{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Episode.changeset(%Episode{}, %{})
    refute changeset.valid?
  end

  test "changeset requires published_at" do
    changeset = Episode.changeset(%Episode{}, Map.put(@valid_attrs, :published_at, nil))
    assert {:published_at, "can't be blank"} in errors_on_changeset(changeset)
  end

  test "changeset requires title" do
    changeset = Episode.changeset(%Episode{}, Map.put(@valid_attrs, :title, nil))
    assert {:title, "can't be blank"} in errors_on_changeset(changeset)
  end

  test "changeset requires url" do
    changeset = Episode.changeset(%Episode{}, Map.put(@valid_attrs, :url, nil))
    assert {:url, "can't be blank"} in errors_on_changeset(changeset)
  end

  test "changeset requires unique url" do
    Factory.insert(:episode, %{url: "http://unique.com"})

    {:error, changeset} =
      %Episode{}
      |> Episode.changeset(Map.put(@valid_attrs, :url, "http://unique.com"))
      |> Repo.insert

    assert {:url, "has already been taken"} in errors_on_changeset(changeset)
  end
end
