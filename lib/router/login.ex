defmodule Router.Login do
  @moduledoc """
  根据手机号登录

  **Path:** `/login`

  **Query:**
  - `phone`: 手机号
  - `password`: 密码

  **Example**
  - `/login?phone=129&password=abc`
  """
  import Plug.Conn
  import Helpers.Util

  def init(options), do: options

  def call(conn, _opts) do
    resp = dispatch(conn.query_params)

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
    |> NeteaseMusicApi.Cache.put_into_cache(body)
  end

  def dispatch(%{ "phone" => phone, "password" => password }, cookie \\ "") do
    data = %{
      "phone" => phone,
      "password" => :crypto.hash(:md5, password) |> Base.encode16(case: :lower) ,
      "rememberLogin" => true
    }
    createWebRequest(
      :post,
      "music.163.com",
      "/weapi/login/cellphone",
      data,
      cookie
    )
  end
end