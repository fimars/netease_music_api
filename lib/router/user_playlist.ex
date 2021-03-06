defmodule Router.User.Playlist do
  @moduledoc """
  用户播放列表

  **Path:** `/user/playlist`

  **Query:**
  - `uid`: 用户id

  **Example**
  - `/user/playlist?uid=350652322`
  """
  import Plug.Conn
  import Helpers.Util

  def init(options), do: options

  def call(conn, _opts) do
    body =
      conn
      |> get_req_header("cookie")
      |> dispatch(conn.query_params)
      |> Map.get(:body)

    conn
    |> send_resp(200, body)
  end

  def dispatch(cookie, %{"uid" => uid}) do
    data = %{
      "uid" => uid,
      "offset" => 0,
      "limit" => 1000,
      "csrf_token" => ''
    }

    createWebRequest(
      :post,
      "music.163.com",
      "/weapi/user/playlist",
      data,
      cookie
    )
  end
end
