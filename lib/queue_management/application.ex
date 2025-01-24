defmodule QueueManagement.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      QueueManagementWeb.Telemetry,
      QueueManagement.Repo,
      {DNSCluster, query: Application.get_env(:queue_management, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: QueueManagement.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: QueueManagement.Finch},
      # Start a worker by calling: QueueManagement.Worker.start_link(arg)
      # {QueueManagement.Worker, arg},
      # Start to serve requests, typically the last entry
      QueueManagementWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QueueManagement.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QueueManagementWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
