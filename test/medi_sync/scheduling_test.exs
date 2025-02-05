defmodule MediSync.SchedulingTest do
  use MediSync.DataCase

  alias MediSync.Scheduling

  describe "appointments" do
    alias MediSync.Scheduling.Appointment

    import MediSync.SchedulingFixtures

    @invalid_attrs %{status: nil, start_at: nil, end_at: nil, notes: nil}

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert Scheduling.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert Scheduling.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      valid_attrs = %{status: "some status", start_at: ~U[2025-02-04 14:52:00Z], end_at: ~U[2025-02-04 14:52:00Z], notes: "some notes"}

      assert {:ok, %Appointment{} = appointment} = Scheduling.create_appointment(valid_attrs)
      assert appointment.status == "some status"
      assert appointment.start_at == ~U[2025-02-04 14:52:00Z]
      assert appointment.end_at == ~U[2025-02-04 14:52:00Z]
      assert appointment.notes == "some notes"
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduling.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      update_attrs = %{status: "some updated status", start_at: ~U[2025-02-05 14:52:00Z], end_at: ~U[2025-02-05 14:52:00Z], notes: "some updated notes"}

      assert {:ok, %Appointment{} = appointment} = Scheduling.update_appointment(appointment, update_attrs)
      assert appointment.status == "some updated status"
      assert appointment.start_at == ~U[2025-02-05 14:52:00Z]
      assert appointment.end_at == ~U[2025-02-05 14:52:00Z]
      assert appointment.notes == "some updated notes"
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduling.update_appointment(appointment, @invalid_attrs)
      assert appointment == Scheduling.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = Scheduling.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> Scheduling.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = Scheduling.change_appointment(appointment)
    end
  end
end
