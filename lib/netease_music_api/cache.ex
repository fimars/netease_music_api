defmodule NeteaseMusicApi.Cache do
    @moduledoc """
    This is a cache plug for restapi.
    """
    use Agent
    import Plug.Conn

    def start_link([]) do
        Agent.start_link(fn -> Map.new end, name: __MODULE__)
    end

    @doc """
    Set a requery & response into Cache.

    Returns :ok
    """
    def put_into_cache(%Plug.Conn{state: :unset} = conn, _body), do: conn
    def put_into_cache(%Plug.Conn{state: :sent} = conn, body) do
        Agent.update(__MODULE__, &Map.put(&1, key(conn), body))
        conn
    end

    # TODO: Add Expiration Time
    def get_resp_cache(%Plug.Conn{} = conn, _opts) do
        case Agent.get(__MODULE__, &Map.get(&1, key(conn))) do
            nil -> conn
            body -> conn |> send_resp(200, body) |> halt()
        end
    end

    defp key(%Plug.Conn{query_string: query, request_path: path}) do
        "#{path}#{query}"
    end
end