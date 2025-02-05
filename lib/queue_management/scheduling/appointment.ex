defmodule QueueManagement.Scheduling.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :status, :string
    field :start_at, :utc_datetime
    field :end_at, :utc_datetime
    field :notes, :string

    belongs_to :patient, QueueManagement.Accounts.User
    belongs_to :doctor,  QueueManagement.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:start_at, :end_at, :notes, :status])
    |> validate_required([:start_at, :end_at, :notes, :status])
  end
end
