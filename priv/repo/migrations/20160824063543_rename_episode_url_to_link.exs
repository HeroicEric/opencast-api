defmodule Opencast.Repo.Migrations.RenameEpisodeUrlToLink do
  use Ecto.Migration

  def up do
    rename table(:episodes), :url, to: :link

    drop unique_index(:episodes, [:url])
    drop unique_index(:episodes, [:url, :podcast_id])

    create unique_index(:episodes, [:link])
    create unique_index(:episodes, [:link, :podcast_id])
  end

  def down do
    rename table(:episodes), :link, to: :url

    drop unique_index(:episodes, [:link])
    drop unique_index(:episodes, [:link, :podcast_id])

    create unique_index(:episodes, [:url])
    create unique_index(:episodes, [:url, :podcast_id])
  end
end
