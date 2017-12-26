import Helpers.Util
defmodule API.Dispatch do
  def login(%{ "phone" => phone, "password" => password }, cookie \\ "") do
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

  def user_subcount(cookie) do
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

  def user_playlist(%{ "uid" => uid }, cookie) do
    data = %{
      "offset" => 0,
      "uid" => uid,
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