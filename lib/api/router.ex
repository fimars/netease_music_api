defmodule API.Router do
  alias API.Dispatch

  use Plug.Router
  # Notice the router contains a plug pipeline and by default it requires two
  # plugs: match and dispatch. match is responsible for finding a matching route
  # which is then forwarded to dispatch. This means users can easily hook into 
  # the router mechanism and add behaviour before match, before dispatch or after both.

  plug :match
  # decode json
  plug Plug.Parsers, parsers: [:json],
                              pass:  ["application/json"],
                              json_decoder: Poison
  # put response ContentType: "application/json"
  plug :put_resp_content_type, "application/json"
  plug :dispatch


  # 登录接口
  match "/login" do
    resp = Dispatch.login(conn.query_params)
    
    cookies =
      resp
      |> Map.get(:headers)
      |> Helpers.Find.all_matches("set-cookie")
      |> Enum.map(&(elem(&1, 1)))
      |> Enum.join("; ")

    body = resp |> Map.get(:body)

    conn
    |> put_resp_header("Set-Cookie", cookies) # Set Cookie 可能需要抽象成中间件
    |> send_resp(200,  body)
  end

  # 获取用户信息,歌单，收藏，mv, dj 数量
  get "/user/subcount" do
    cookie = conn |> get_req_header("cookie")
    resp = Dispatch.user_subcount(cookie)

    conn
    |> send_resp(200,  resp |> Map.get(:body))
  end

  # 获取用户歌单
  get "/user/playlist" do
    cookie = conn |> get_req_header("cookie")
    resp = Dispatch.user_playlist(conn.query_params, cookie)

    conn
    |> send_resp(200,  resp |> Map.get(:body))
  end

  # cookie测试
  get "/cookie" do
    conn
    |> put_resp_header("Set-Cookie", "a=1")
    |> send_resp(200, "cookie be seted.")
  end
  
  get "/hello" do
    send_resp(conn, 200, Poison.encode!(%{ "message" => "word" }))
  end

  match _ do
    send_resp(conn, 404, "Not Founc")
  end
end