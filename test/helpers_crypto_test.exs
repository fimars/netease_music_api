defmodule HelpersCryptoTest do
  use ExUnit.Case
  doctest Helpers.Crypto

  test "encrypt" do
    assert Helpers.Crypto.encrypt(%{"a" => 1}, "1L47NtP7mu7syIX9") ==
      %{
        "encSeckey" => "08cea6ba9b55a3680f699c8d8fa4a5c59c183479e58e1f3ee5318ca33341a0bab2a50cd20af65a61da027f1eeaba055f13d8f4d71753fae466fc5288d980bc67facfc3610f9bca3a772044ecb3053fcb3ed91d8f3247f908b50d3d81649f8d50b818f2091c274e76451b3bb305cd36818e7717e6919bc745e8debe1f1272dfc8",
        "params" => "E6Q7oh996VSZSV23MxmjB2SYmJZUtU3HtAAI6Lwoxms="
      }
  end
end
