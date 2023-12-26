defmodule TransportersHub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TransportersHubWeb.Telemetry,
      # Start the Ecto repository
      TransportersHub.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TransportersHub.PubSub},
      # Start Finch
      {Finch, name: TransportersHub.Finch},
      # Start the Endpoint (http/https)
      TransportersHubWeb.Endpoint
      # Start a worker by calling: TransportersHub.Worker.start_link(arg)
      # {TransportersHub.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TransportersHub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TransportersHubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
