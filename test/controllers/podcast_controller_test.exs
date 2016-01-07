defmodule Opencast.PodcastControllerTest do
  use Opencast.ConnCase

  alias Opencast.Podcast

  setup do
    conn = conn() |> put_req_header("accept", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    podcast1 = create(:podcast)
    podcast2 = create(:podcast)
    podcast3 = create(:podcast)

    conn = get conn, podcast_path(conn, :index)

    assert json_response(conn, 200)["data"] == [
      %{
        "type" => "podcast",
        "id" => podcast1.id,
        "attributes" => %{
          "feed-url" => podcast1.feed_url,
          "image-url" => podcast1.image_url,
          "link" => podcast1.link,
          "description" => podcast1.description,
          "title" => podcast1.title
        }
      },
      %{
        "type" => "podcast",
        "id" => podcast2.id,
        "attributes" => %{
          "feed-url" => podcast2.feed_url,
          "image-url" => podcast2.image_url,
          "link" => podcast2.link,
          "description" => podcast2.description,
          "title" => podcast2.title
        }
      },
      %{
        "type" => "podcast",
        "id" => podcast3.id,
        "attributes" => %{
          "feed-url" => podcast3.feed_url,
          "image-url" => podcast3.image_url,
          "link" => podcast3.link,
          "description" => podcast3.description,
          "title" => podcast3.title
        }
      }
    ]
  end

  test "shows chosen resource", %{conn: conn} do
    podcast = create(:podcast)

    conn = get conn, podcast_path(conn, :show, podcast)

    assert json_response(conn, 200)["data"] == %{
      "type" => "podcast",
      "id" => podcast.id,
      "attributes" => %{
        "feed-url" => podcast.feed_url,
        "image-url" => podcast.image_url,
        "link" => podcast.link,
        "description" => podcast.description,
        "title" => podcast.title
      }
    }
  end

  # see https://github.com/phoenixframework/phoenix_ecto/issues/28
  @tag :skip
  test "doesn't show resource and throws error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, podcast_path(conn, :show, -1)
    end
  end
end
