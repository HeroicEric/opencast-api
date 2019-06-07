defmodule Opencast.Directory.Podcast do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "podcasts" do
    has_many :episodes, Opencast.Directory.Episode

    field :description, :string
    field :feed_url, :string
    field :image_url, :string
    field :link, :string
    field :title, :string

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(podcast, attrs) do
    podcast
    |> cast(attrs, [:description, :feed_url, :image_url, :link, :title])
    |> validate_required([:description, :feed_url, :link, :title])
    |> unique_constraint(:feed_url)
  end
end
