defmodule QueueManagement.Repo do
  use Ecto.Repo,
    otp_app: :queue_management,
    adapter: Ecto.Adapters.Postgres
end
