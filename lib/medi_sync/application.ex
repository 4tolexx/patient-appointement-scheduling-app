defmodule MediSync.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MediSyncWeb.Telemetry,
      MediSync.Repo,
      {DNSCluster, query: Application.get_env(:medi_sync, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MediSync.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MediSync.Finch},
      # Start a worker by calling: MediSync.Worker.start_link(arg)
      # {MediSync.Worker, arg},
      # Start to serve requests, typically the last entry
      MediSyncWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MediSync.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MediSyncWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
