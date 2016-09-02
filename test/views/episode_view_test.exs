defmodule Opencast.EpisodeViewTest do
  use Opencast.ConnCase, async: true

  @view Opencast.EpisodeView

  test "show.json-api: return json episode", %{conn: conn} do
    podcast = build(:podcast, id: "123")
    episode = build(:episode, podcast: podcast, id: "456")

    json = @view.render("show.json-api", conn: conn, data: episode)

    assert json["data"] == %{
      "attributes" => %{
        "description" => episode.description,
        "link" => episode.link,
        "published-at" => episode.published_at,
        "title" => episode.title
      },
      "id" => episode.id,
      "links" => %{
        "self" => episode_path(conn, :show, episode.id)
      },
      "relationships" => %{
        "podcast" => %{
          "data" => %{
            "id" => podcast.id,
            "type" => "podcasts"
          },
          "links" => %{
            "related" => episode_related_podcast_path(conn, :related_podcast, episode)
          }
        }
      },
      "type" => "episodes"
    }
  end

  test "attributes.description is sanitized", %{conn: conn} do
    description = "<section><header><script>code!</script></header><p>hello <script>code!</script></p></section>"
    sanitized_description = "code!<p>hello code!</p>"
    episode = build(:episode, description: description)

    json = @view.render("show.json-api", conn: conn, data: episode)

    assert json["data"]["attributes"]["description"] == sanitized_description
  end
end
