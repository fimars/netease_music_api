defmodule Router.User.Subcount do
  @moduledoc """
  获取用户信息,歌单，收藏，mv, dj 数量, 需要**登录**后调用

  **Path:** `/user/subcount`

  **Example**
  - `/user/subcount`
  """
  import Plug.Conn
  import Helpers.Util

  def init(options), do: options
  def call(conn, _opts) do
    body =
      conn
      |> get_req_header("cookie")
      |> dispatch
      |> Map.get(:body)

    conn
    |> send_resp(200, body)
  end
  
  def dispatch(cookie) do
    data = %{
      "csrf_token" => "" 
    }
    createWebRequest(
      :post,
      "music.163.com",
      "/weapi/subcount",
      data,
      cookie
    )
  end
end