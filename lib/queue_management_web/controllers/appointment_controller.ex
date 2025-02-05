defmodule QueueManagementWeb.AppointmentController do
  use QueueManagementWeb, :controller

  alias QueueManagement.Scheduling
  alias QueueManagement.Scheduling.Appointment

  def index(conn, _params) do
    appointments = Scheduling.list_appointments()
    render(conn, :index, appointments: appointments)
  end

  def new(conn, _params) do
    changeset = Scheduling.change_appointment(%Appointment{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"appointment" => appointment_params}) do
    case Scheduling.create_appointment(appointment_params) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment created successfully.")
        |> redirect(to: ~p"/appointments/#{appointment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    appointment = Scheduling.get_appointment!(id)
    render(conn, :show, appointment: appointment)
  end

  def edit(conn, %{"id" => id}) do
    appointment = Scheduling.get_appointment!(id)
    changeset = Scheduling.change_appointment(appointment)
    render(conn, :edit, appointment: appointment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    appointment = Scheduling.get_appointment!(id)

    case Scheduling.update_appointment(appointment, appointment_params) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment updated successfully.")
        |> redirect(to: ~p"/appointments/#{appointment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, appointment: appointment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    appointment = Scheduling.get_appointment!(id)
    {:ok, _appointment} = Scheduling.delete_appointment(appointment)

    conn
    |> put_flash(:info, "Appointment deleted successfully.")
    |> redirect(to: ~p"/appointments")
  end
end
