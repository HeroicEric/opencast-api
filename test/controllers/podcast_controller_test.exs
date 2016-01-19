defmodule Opencast.PodcastControllerTest do
  use Opencast.ConnCase

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
        "type" => "podcasts",
        "relationships" => %{
          "episodes" => %{
            "links" => %{
              "related" => podcast_related_episodes_url(conn, :related_episodes, podcast1)
            },
            "data" => []
          }
        },
        "links" => %{"self" => podcast_url(conn, :show, podcast1.id)},
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
        "type" => "podcasts",
        "relationships" => %{
          "episodes" => %{
            "links" => %{
              "related" => podcast_related_episodes_url(conn, :related_episodes, podcast2)
            },
            "data" => []
          }
        },
        "links" => %{"self" => podcast_url(conn, :show, podcast2.id)},
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
        "type" => "podcasts",
        "relationships" => %{
          "episodes" => %{
            "links" => %{
              "related" => podcast_related_episodes_url(conn, :related_episodes, podcast3)
            },
            "data" => []
          }
        },
        "links" => %{"self" => podcast_url(conn, :show, podcast3.id)},
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
      "type" => "podcasts",
      "relationships" => %{
        "episodes" => %{
          "links" => %{
            "related" => podcast_related_episodes_url(conn, :related_episodes, podcast)
          },
          "data" => []
        }
      },
      "links" => %{"self" => podcast_url(conn, :show, podcast.id)},
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

  test "lists related episodes by published_at", %{conn: conn} do
    podcast = create(:podcast)
    old_episode = create(:episode, %{
      podcast: podcast,
      published_at: Ecto.DateTime.cast!("2014-01-19T04:23:12Z")
    })
    oldest_episode = create(:episode, %{
      podcast: podcast,
      published_at: Ecto.DateTime.cast!("2012-01-19T04:23:12Z")
    })
    new_episode = create(:episode, %{
      podcast: podcast,
      published_at: Ecto.DateTime.cast!("2016-01-19T04:23:12Z")
    })
    path = podcast_related_episodes_path(conn, :related_episodes, podcast)

    conn = get conn, path

    assert json_response(conn, 200)["data"] == [
      %{
        "type" => "episodes",
        "relationships" => %{
          "podcast" => %{
            "links" => %{
              "related" => episode_related_podcast_url(conn, :related_podcast, new_episode)
            },
            "data" => %{"type" => "podcasts", "id" => new_episode.podcast.id}
          }
        },
        "links" => %{"self" => episode_url(conn, :show, new_episode.id)},
        "id" => new_episode.id,
        "attributes" => %{
          "url" => new_episode.url,
          "title" => new_episode.title,
          "description" => new_episode.description,
          "published-at" => Ecto.DateTime.to_iso8601(new_episode.published_at)
        }
      },
      %{
        "type" => "episodes",
        "relationships" => %{
          "podcast" => %{
            "links" => %{
              "related" => episode_related_podcast_url(conn, :related_podcast, old_episode)
            },
            "data" => %{"type" => "podcasts", "id" => old_episode.podcast.id}
          }
        },
        "links" => %{"self" => episode_url(conn, :show, old_episode.id)},
        "id" => old_episode.id,
        "attributes" => %{
          "url" => old_episode.url,
          "title" => old_episode.title,
          "description" => old_episode.description,
          "published-at" => Ecto.DateTime.to_iso8601(old_episode.published_at)
        }
      },
      %{
        "type" => "episodes",
        "relationships" => %{
          "podcast" => %{
            "links" => %{
              "related" => episode_related_podcast_url(conn, :related_podcast, oldest_episode)
            },
            "data" => %{"type" => "podcasts", "id" => oldest_episode.podcast.id}
          }
        },
        "links" => %{"self" => episode_url(conn, :show, oldest_episode.id)},
        "id" => oldest_episode.id,
        "attributes" => %{
          "url" => oldest_episode.url,
          "title" => oldest_episode.title,
          "description" => oldest_episode.description,
          "published-at" => Ecto.DateTime.to_iso8601(oldest_episode.published_at)
        }
      }
    ]
  end
end
