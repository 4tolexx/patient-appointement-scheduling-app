defmodule MediSync.Repo.Migrations.RemoveOauthFieldsFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :is_oauth_user
    end
  end
end
