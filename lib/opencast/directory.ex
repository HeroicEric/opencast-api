defmodule Opencast.Directory do
  @moduledoc """
  The Directory context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Changeset
  alias Opencast.Directory.Episode
  alias Opencast.Directory.Podcast
  alias Opencast.Repo

  @spec create_episode(map) :: {:ok, %Episode{}} | {:error, %Changeset{}}
  def create_episode(attrs \\ %{}) do
    %Episode{}
    |> Episode.changeset(attrs)
    |> Repo.insert()
  end

  @spec create_podcast(map) :: {:ok, %Podcast{}} | {:error, %Changeset{}}
  def create_podcast(attrs \\ %{}) do
    %Podcast{}
    |> Podcast.changeset(attrs)
    |> Repo.insert()
  end

  @spec get_podcast!(Ecto.UUID.t()) :: %Podcast{} | no_return
  def get_podcast!(id), do: Repo.get!(Podcast, id)
end
