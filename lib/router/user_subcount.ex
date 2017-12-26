defmodule Router.User.Subcount do
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