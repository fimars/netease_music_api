defmodule NeteaseMusicApiTest do
  use ExUnit.Case
  doctest NeteaseMusicApi

  test "greets the world" do
    assert NeteaseMusicApi.hello() == :world
  end
end
