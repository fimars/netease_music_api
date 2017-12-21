defmodule API.Router do
  alias API.Dispatch

  use Plug.Router
  plug :match
  plug Plug.Parsers, parsers: [:json],
                     pass:  ["application/json"],
                     json_decoder: Poison
  plug :dispatch

  # 登录接口
  match "/login" do
    conn
    |> send_resp(200, Dispatch.login(conn.query_params) |> Map.get(:body))
  end

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end