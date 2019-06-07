defmodule OpencastWeb.API.V1.PodcastControllerTest do
  use OpencastWeb.ConnCase, async: true

  alias Opencast.Factory

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    podcast1 = Factory.insert(:podcast)
    podcast2 = Factory.insert(:podcast)
    podcast3 = Factory.insert(:podcast)

    conn = get(conn, Routes.api_v1_podcast_path(conn, :index))

    assert json_response(conn, 200)["data"] == [
             %{
               "type" => "podcasts",
               "relationships" => %{
                 "episodes" => %{
                   "links" => %{
                     "related" =>
                       Routes.api_v1_podcast_related_episodes_path(
                         conn,
                         :related_episodes,
                         podcast1.id
                       )
                   }
                 }
               },
               "links" => %{"self" => Routes.api_v1_podcast_path(conn, :show, podcast1.id)},
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
                     "related" =>
                       Routes.api_v1_podcast_related_episodes_path(
                         conn,
                         :related_episodes,
                         podcast2.id
                       )
                   }
                 }
               },
               "links" => %{"self" => Routes.api_v1_podcast_path(conn, :show, podcast2.id)},
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
                     "related" =>
                       Routes.api_v1_podcast_related_episodes_path(
                         conn,
                         :related_episodes,
                         podcast3
                       )
                   }
                 }
               },
               "links" => %{"self" => Routes.api_v1_podcast_path(conn, :show, podcast3.id)},
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

  test "index: is paginated", %{conn: conn} do
    Factory.insert_list(5, :podcast)

    conn =
      get(
        conn,
        Routes.api_v1_podcast_path(conn, :index, %{"page" => %{"number" => 2, "size" => 1}})
      )

    response = json_response(conn, 200)

    assert length(response["data"]) == 1

    assert response["links"] == %{
             "self" =>
               Routes.api_v1_podcast_path(conn, :index, %{"page" => %{"number" => 2, "size" => 1}}),
             "prev" =>
               Routes.api_v1_podcast_path(conn, :index, %{"page" => %{"number" => 1, "size" => 1}}),
             "next" =>
               Routes.api_v1_podcast_path(conn, :index, %{"page" => %{"number" => 3, "size" => 1}}),
             "last" =>
               Routes.api_v1_podcast_path(conn, :index, %{"page" => %{"number" => 5, "size" => 1}}),
             "first" =>
               Routes.api_v1_podcast_path(conn, :index, %{"page" => %{"number" => 1, "size" => 1}})
           }
  end

  test "index: is filterable", %{conn: conn} do
    Factory.insert(:podcast, %{title: "Bear Soup"})
    Factory.insert(:podcast, %{title: "Lentil Soup"})
    Factory.insert(:podcast, %{title: "Bear Attack"})

    conn =
      get(conn, Routes.api_v1_podcast_path(conn, :index, %{"filter" => %{"query" => "soup"}}))

    response = json_response(conn, 200)

    titles =
      Enum.map(response["data"], fn podcast ->
        get_in(podcast, ["attributes", "title"])
      end)

    assert titles == ["Bear Soup", "Lentil Soup"]
  end

  test "shows chosen resource", %{conn: conn} do
    podcast = Factory.insert(:podcast)

    conn = get(conn, Routes.api_v1_podcast_path(conn, :show, podcast.id))

    assert json_response(conn, 200)["data"] == %{
             "type" => "podcasts",
             "relationships" => %{
               "episodes" => %{
                 "links" => %{
                   "related" =>
                     Routes.api_v1_podcast_related_episodes_path(
                       conn,
                       :related_episodes,
                       podcast.id
                     )
                 }
               }
             },
             "links" => %{"self" => Routes.api_v1_podcast_path(conn, :show, podcast.id)},
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
      get(conn, Routes.api_v1_podcast_path(conn, :show, -1))
    end
  end

  test "lists related episodes by published_at", %{conn: conn} do
    podcast = Factory.insert(:podcast)

    old_episode =
      Factory.insert(:episode, %{
        podcast: podcast,
        published_at: DateTime.from_naive!(~N[2014-01-19 04:23:12], "Etc/UTC")
      })

    oldest_episode =
      Factory.insert(:episode, %{
        podcast: podcast,
        published_at: DateTime.from_naive!(~N[2012-01-19 04:23:12], "Etc/UTC")
      })

    new_episode =
      Factory.insert(:episode, %{
        podcast: podcast,
        published_at: DateTime.from_naive!(~N[2016-01-19 04:23:12], "Etc/UTC")
      })

    path = Routes.api_v1_podcast_related_episodes_path(conn, :related_episodes, podcast.id)

    conn = get(conn, path)

    assert json_response(conn, 200)["data"] == [
             %{
               "type" => "episodes",
               "relationships" => %{
                 "podcast" => %{
                   "links" => %{
                     "related" =>
                       Routes.api_v1_episode_related_podcast_path(
                         conn,
                         :related_podcast,
                         new_episode.id
                       )
                   },
                   "data" => %{"type" => "podcasts", "id" => new_episode.podcast.id}
                 }
               },
               "links" => %{"self" => Routes.api_v1_episode_path(conn, :show, new_episode.id)},
               "id" => new_episode.id,
               "attributes" => %{
                 "link" => new_episode.link,
                 "title" => new_episode.title,
                 "description" => new_episode.description,
                 "published-at" => DateTime.to_iso8601(new_episode.published_at)
               }
             },
             %{
               "type" => "episodes",
               "relationships" => %{
                 "podcast" => %{
                   "links" => %{
                     "related" =>
                       Routes.api_v1_episode_related_podcast_path(
                         conn,
                         :related_podcast,
                         old_episode.id
                       )
                   },
                   "data" => %{"type" => "podcasts", "id" => old_episode.podcast.id}
                 }
               },
               "links" => %{"self" => Routes.api_v1_episode_path(conn, :show, old_episode.id)},
               "id" => old_episode.id,
               "attributes" => %{
                 "link" => old_episode.link,
                 "title" => old_episode.title,
                 "description" => old_episode.description,
                 "published-at" => DateTime.to_iso8601(old_episode.published_at)
               }
             },
             %{
               "type" => "episodes",
               "relationships" => %{
                 "podcast" => %{
                   "links" => %{
                     "related" =>
                       Routes.api_v1_episode_related_podcast_path(
                         conn,
                         :related_podcast,
                         oldest_episode.id
                       )
                   },
                   "data" => %{"type" => "podcasts", "id" => oldest_episode.podcast.id}
                 }
               },
               "links" => %{"self" => Routes.api_v1_episode_path(conn, :show, oldest_episode.id)},
               "id" => oldest_episode.id,
               "attributes" => %{
                 "link" => oldest_episode.link,
                 "title" => oldest_episode.title,
                 "description" => oldest_episode.description,
                 "published-at" => DateTime.to_iso8601(oldest_episode.published_at)
               }
             }
           ]
  end
end
