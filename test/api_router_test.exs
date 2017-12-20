defmodule ApiRouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts ApiRouter.init([])

  test "returns hello world" do
    # Create a test connection
    conn = conn(:get, "/hello")

    # Invoke the plug
    conn = ApiRouter.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end

  test "login" do
    conn = conn(:post, "/login", %{phone: 15920013839, password: "unknow"})

    conn = ApiRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "login"
  end
end