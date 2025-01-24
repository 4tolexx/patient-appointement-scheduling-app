defmodule QueueManagement.Repo.Migrations.DropProfileTable do
  use Ecto.Migration

  def change do
    drop table(:profiles)
  end
end
