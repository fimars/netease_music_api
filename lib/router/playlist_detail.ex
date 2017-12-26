defmodule Router.Playlist.Detail do
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
  
  def dispatch(cookie, %{ "id" => id }) do
    data = %{
      "id" => id,
      "n" => 1000,
      "offset" => 0,
      "total" => true,
      "limit" => 1000,
      "csrf_token" => ''
    }
    createWebRequest(
      :post,
      "music.163.com",
      "/weapi/v3/playlist/detail",
      data,
      cookie
    )
  end
end