defmodule NeteaseMusicApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    port =
      case Mix.env do
        :test -> 4002
        _ -> 4001
      end

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: NeteaseMusicApi.Worker.start_link(arg)
      # {NeteaseMusicApi.Worker, arg},
      Plug.Adapters.Cowboy.child_spec(:http, API.Router, [], [port: port])
    ]
    # Log port 4001 be listened.
    IO.ANSI.format([:red, :bright, "\n[NeteaseMusicAPI] #{port} be listened.\n"], true) |> IO.puts

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NeteaseMusicApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
