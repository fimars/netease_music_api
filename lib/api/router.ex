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
    resp = Dispatch.login(conn.query_params)
    
    body = resp |> Map.get(:body)
    cookies =
      resp
      |> Map.get(:headers)
      |> Helpers.Find.all_matches("set-cookie")
      |> Enum.map(&(elem(&1, 1)))
      |> Enum.join("; ")

    conn
    |> put_resp_header("Set-Cookie", cookies) # Set Cookie 可能需要抽象成中间件
    |> put_resp_content_type("application/json")
    |> send_resp(200,  body)
  end

  # cookie测试
  get "/cookie" do
    conn
    |> put_resp_header("Set-Cookie", "a=1")
    |> send_resp(200, "cookie be seted.")
  end
  
  get "/hello" do
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end