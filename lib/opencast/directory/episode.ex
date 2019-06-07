defmodule Opencast.Directory.Episode do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "episodes" do
    belongs_to :podcast, Opencast.Directory.Podcast

    field :description, :string
    field :link, :string
    field :published_at, :utc_datetime_usec
    field :title, :string

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(episode, attrs) do
    episode
    |> cast(attrs, [:description, :link, :podcast_id, :published_at, :title])
    |> validate_required([:link, :podcast_id, :published_at, :title])
    |> foreign_key_constraint(:podcast_id)
    |> unique_constraint(:link)
  end
end
