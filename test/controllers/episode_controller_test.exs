defmodule Opencast.EpisodeControllerTest do
  use Opencast.ConnCase

  setup do
    conn = conn() |> put_req_header("accept", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    [episode1, episode2, episode3] = create_list(3, :episode)

    conn = get conn, episode_path(conn, :index)

    assert json_response(conn, 200)["data"] == [
      %{
        "type" => "episodes",
        "relationships" => %{
          "podcast" => %{
            "links" => %{
              "related" => episode_related_podcast_url(conn, :related_podcast, episode1)
            },
            "data" => %{"type" => "podcast", "id" => episode1.podcast.id}
          }
        },
        "links" => %{"self" => episode_url(conn, :show, episode1.id)},
        "id" => episode1.id,
        "attributes" => %{
          "url" => episode1.url,
          "title" => episode1.title,
          "description" => episode1.description,
          "published-at" => Ecto.DateTime.to_iso8601(episode1.published_at)
        }
      },
      %{
        "type" => "episodes",
        "relationships" => %{
          "podcast" => %{
            "links" => %{
              "related" => episode_related_podcast_url(conn, :related_podcast, episode2)
            },
            "data" => %{"type" => "podcast", "id" => episode2.podcast.id}
          }
        },
        "links" => %{"self" => episode_url(conn, :show, episode2.id)},
        "id" => episode2.id,
        "attributes" => %{
          "url" => episode2.url,
          "title" => episode2.title,
          "description" => episode2.description,
          "published-at" => Ecto.DateTime.to_iso8601(episode2.published_at)
        }
      },
      %{
        "type" => "episodes",
        "relationships" => %{
          "podcast" => %{
            "links" => %{
              "related" => episode_related_podcast_url(conn, :related_podcast, episode3)
            },
            "data" => %{"type" => "podcast", "id" => episode3.podcast.id}
          }
        },
        "links" => %{"self" => episode_url(conn, :show, episode3.id)},
        "id" => episode3.id,
        "attributes" => %{
          "url" => episode3.url,
          "title" => episode3.title,
          "description" => episode3.description,
          "published-at" => Ecto.DateTime.to_iso8601(episode3.published_at)
        }
      }
    ]
  end

  test "shows chosen resource", %{conn: conn} do
    episode = create(:episode)

    conn = get conn, episode_path(conn, :show, episode)

    assert json_response(conn, 200)["data"] == %{
      "type" => "episodes",
      "relationships" => %{
        "podcast" => %{
          "links" => %{
            "related" => episode_related_podcast_url(conn, :related_podcast, episode)
          },
          "data" => %{"type" => "podcast", "id" => episode.podcast.id}
        }
      },
      "links" => %{"self" => episode_url(conn, :show, episode.id)},
      "id" => episode.id,
      "attributes" => %{
        "url" => episode.url,
        "title" => episode.title,
        "description" => episode.description,
        "published-at" => Ecto.DateTime.to_iso8601(episode.published_at)
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

  test "shows related podcast", %{conn: conn} do
    episode = create(:episode)
    podcast = episode.podcast
    path = episode_related_podcast_path(conn, :related_podcast, episode)

    conn = get conn, path

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
end
