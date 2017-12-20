defmodule ApiRouter do
  use Plug.Router

  plug :match
  plug Plug.Parsers, parsers: [:json],
                     pass:  ["application/json"],
                     json_decoder: Poison
  plug :dispatch

  # 登录接口
  match "/login" do
    IO.inspect conn.query_params # Prints JSON query
    IO.inspect conn.body_params # Prints JSON POST body
    send_resp(conn, 200, "login")
  end

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end