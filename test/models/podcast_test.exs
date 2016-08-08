defmodule Opencast.PodcastTest do
  use Opencast.ModelCase
  import Opencast.Factory

  alias Opencast.Podcast

  test "changeset with valid attributes" do
    changeset = Podcast.changeset(%Podcast{}, params_for(:podcast))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Podcast.changeset(%Podcast{}, %{})
    refute changeset.valid?
  end

  test "changeset requires description" do
    changeset = Podcast.changeset(%Podcast{}, %{description: nil})
    assert {:description, "can't be blank"} in errors_on_changeset(changeset)
  end

  test "changeset requires feed_url" do
    changeset = Podcast.changeset(%Podcast{}, %{feed_url: nil})
    assert {:feed_url, "can't be blank"} in errors_on_changeset(changeset)
  end

  test "changeset requires link" do
    changeset = Podcast.changeset(%Podcast{}, %{link: nil})
    assert {:link, "can't be blank"} in errors_on_changeset(changeset)
  end

  test "changeset requires title" do
    changeset = Podcast.changeset(%Podcast{}, %{title: nil})
    assert {:title, "can't be blank"} in errors_on_changeset(changeset)
  end

  test "changeset requires unique feed_url" do
    insert(:podcast, %{feed_url: "http://example.com"})

    {:error, changeset} = %Podcast{}
      |> Podcast.changeset(params_for(:podcast, %{feed_url: "http://example.com"}))
      |> Repo.insert

    assert {:feed_url, "has already been taken"} in errors_on_changeset(changeset)
  end
end
