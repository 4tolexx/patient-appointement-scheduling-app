defmodule MediSync.SchedulingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MediSync.Scheduling` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        end_at: ~U[2025-02-04 14:52:00Z],
        notes: "some notes",
        start_at: ~U[2025-02-04 14:52:00Z],
        status: "some status"
      })
      |> MediSync.Scheduling.create_appointment()

    appointment
  end
end
