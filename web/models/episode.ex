defmodule Opencast.Episode do
  use Opencast.Web, :model

  schema "episodes" do
    belongs_to :podcast, Opencast.Podcast

    field :description, :string
    field :link, :string
    field :published_at, Ecto.DateTime
    field :title, :string

    timestamps
  end

  @required_fields ~w(published_at link title podcast_id)
  @optional_fields ~w(description)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:link)
    |> foreign_key_constraint(:podcast_id)
  end
end
