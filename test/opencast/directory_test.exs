defmodule Opencast.DirectoryTest do
  use Opencast.DataCase

  alias Opencast.Directory
  alias Opencast.Directory.Podcast
  alias Opencast.Factory

  describe "create_podcast/1" do
    test "with valid data creates a podcast" do
      attrs =
        Factory.params_for(:podcast, %{
          description: "Test description",
          feed_url: "http://test-feed.com/fake",
          link: "http://test-link.com/fake",
          title: "Test title"
        })

      assert {:ok, %Podcast{} = podcast} = Directory.create_podcast(attrs)
      assert podcast.description == "Test description"
      assert podcast.feed_url == "http://test-feed.com/fake"
      assert podcast.link == "http://test-link.com/fake"
      assert podcast.title == "Test title"
    end

    test "requires a description" do
      attrs = Factory.params_for(:podcast, description: nil)
      assert {:error, changeset} = Directory.create_podcast(attrs)
      assert %{description: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires a feed_url" do
      attrs = Factory.params_for(:podcast, feed_url: nil)
      assert {:error, changeset} = Directory.create_podcast(attrs)
      assert %{feed_url: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires a link" do
      attrs = Factory.params_for(:podcast, link: nil)
      assert {:error, changeset} = Directory.create_podcast(attrs)
      assert %{link: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires a title" do
      attrs = Factory.params_for(:podcast, title: nil)
      assert {:error, changeset} = Directory.create_podcast(attrs)
      assert %{title: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires unique feed_url" do
      attrs = Factory.params_for(:podcast, feed_url: "http://example.com")
      Factory.insert(:podcast, feed_url: "http://example.com")

      assert {:error, changeset} = Directory.create_podcast(attrs)
      assert %{feed_url: ["has already been taken"]} = errors_on(changeset)
    end
  end
end
