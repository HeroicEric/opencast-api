defmodule Opencast.Repo.Migrations.CreateEpisode do
  use Ecto.Migration

  def change do
    create table(:episodes, primary_key: false) do
      add :description, :text
      add :id, :binary_id, primary_key: true
      add :published_at, :utc_datetime_usec, null: false
      add :title, :string, null: false
      add :url, :string, null: false

      add :podcast_id, references(:podcasts, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:episodes, [:podcast_id])
    create index(:episodes, [:published_at])
    create unique_index(:episodes, [:url])
    create unique_index(:episodes, [:url, :podcast_id])
  end
end
