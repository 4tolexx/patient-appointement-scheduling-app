defmodule QueueManagement.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :full_name, :string, null: false
      add :phone, :string, null: false
      add :bio, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:profiles, [:user_id])
  end
end
