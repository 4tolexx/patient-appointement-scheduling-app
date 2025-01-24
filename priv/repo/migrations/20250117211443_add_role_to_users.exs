defmodule QueueManagement.Repo.Migrations.AddRoleToUsers do
  use Ecto.Migration

  def up do
    execute("CREATE TYPE user_role AS ENUM ('patient', 'doctor', 'admin')")

    alter table(:users) do
      add :role, :user_role, null: false, default: "patient"
    end
  end

  def down do
    alter table(:users) do
      remove :role
    end

    execute("DROP TYPE user_role")
  end
end
