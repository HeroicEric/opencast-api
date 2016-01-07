defmodule Opencast.Repo.Migrations.CreatePodcast do
  use Ecto.Migration

  def change do
    create table(:podcasts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text, null: false
      add :feed_url, :string, null: false
      add :image_url, :string
      add :link, :string, null: false
      add :title, :string, null: false

      timestamps
    end

    create unique_index(:podcasts, [:feed_url])
  end
end
