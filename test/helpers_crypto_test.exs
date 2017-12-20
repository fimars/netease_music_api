defmodule HelpersCryptoTest do
  use ExUnit.Case
  doctest Helpers.Crypto

  test "greets the world" do
    IO.inspect Helpers.Crypto.env
  end
end
