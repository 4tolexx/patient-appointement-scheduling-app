defmodule MediSync.Repo do
  use Ecto.Repo,
    otp_app: :medi_sync,
    adapter: Ecto.Adapters.Postgres
end
