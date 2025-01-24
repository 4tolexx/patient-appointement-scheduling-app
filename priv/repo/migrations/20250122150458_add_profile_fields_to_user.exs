defmodule QueueManagement.Repo.Migrations.AddProfileFieldsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :full_name, :string, null: false
      add :phone_number, :string, null: false
    end
  end
end
