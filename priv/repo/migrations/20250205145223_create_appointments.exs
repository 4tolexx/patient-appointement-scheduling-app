defmodule MediSync.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :start_at, :utc_datetime
      add :end_at, :utc_datetime
      add :notes, :string
      add :status, :string
      add :patient_id, references(:users, on_delete: :delete_all)
      add :doctor_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:appointments, [:patient_id])
    create index(:appointments, [:doctor_id])
  end
end
