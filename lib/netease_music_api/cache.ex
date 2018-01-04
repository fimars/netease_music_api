require Logger
defmodule NeteaseMusicApi.Cache do
    @moduledoc false
    @oversec 60 * 2
    
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
        Agent.update(__MODULE__, &Map.put(&1, key(conn), { Time.utc_now, body }))
        conn
    end

    @doc """
    Get a body by conn

    Returns %Plug.Conn
    """
    def get_resp_cache(%Plug.Conn{} = conn, _opts) do
        case Agent.get(__MODULE__, &Map.get(&1, key(conn))) do
            nil -> conn
            { time, body } ->
                if Time.diff(Time.utc_now, time) > @oversec do
                    conn
                else
                    Logger.info fn -> "[Cache] #{key(conn)} -> #{time}" end
                    conn |> send_resp(200, body) |> halt()
                end
        end
    end

    defp key(%Plug.Conn{query_string: query, request_path: path}) do
        "#{path}#{query}"
    end
end