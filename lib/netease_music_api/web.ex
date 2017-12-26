defmodule NeteaseMusicApi.Web do
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

  # WebAPI
  # 登录接口
  match "/login", to: Router.Login
  # 获取用户信息,歌单，收藏，mv, dj 数量
  get "/user/subcount", to: Router.User.Subcount
  # 获取用户歌单
  get "/user/playlist", to: Router.User.Playlist
  # 获取歌单详情
  get "/playlist/detail", to: Router.Playlist.Detail
  # 获取音乐URL
  get "/music/url", to: Router.Music.Url


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