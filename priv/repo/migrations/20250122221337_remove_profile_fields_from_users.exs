defmodule QueueManagement.Repo.Migrations.RemoveProfileFieldsFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :full_name
      remove :phone_number
    end
  end
end
