defmodule Opencast.Podcast do
  use Opencast.Web, :model

  schema "podcasts" do
    field :description, :string
    field :feed_url, :string
    field :image_url, :string
    field :link, :string
    field :title, :string

    timestamps
  end

  @required_fields ~w(description feed_url link title)
  @optional_fields ~w(image_url)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:feed_url)
  end
end
