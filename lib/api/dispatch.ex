import Helpers.Util
defmodule API.Dispatch do
  def login(%{ "phone" => phone, "password" => password }) do
    data = %{
      "phone" => 15920013839,
      "password" => :crypto.hash(:md5, password) |> Base.encode16(case: :lower) ,
      "rememberLogin" => true
    }
    createWebRequest(:post, "music.163.com", "/weapi/login/cellphone", data, "")
  end
end