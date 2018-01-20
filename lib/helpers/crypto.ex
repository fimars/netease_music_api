defmodule Helpers.Crypto do
  @moduledoc false
  # 常量
  # 参考 https://github.com/darknessomi/musicbox/wiki/
  @nonce "0CoJUm6Qyw8W8jud"
  @modules "00e0b509f6259df8642dbc35662901477df22677ec152b5ff68ace615bb7b725152b3ab17a876aea8a5aa76d2e417629ec4ee341f56135fccf695280104e0312ecbda92557c93870114af6c9d05c4f7f0c3685b7a46bee255932575cce10b424d813cfe4875d3e82047b97ddef52741d546b8e289dc6935b3ece0462db0a22b8e7"
           |> Integer.parse(16)
           |> elem(0)
  @pubkey "010001" |> Integer.parse(16) |> elem(0)
  @keys "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" |> String.codepoints()

  @doc false
  def create_secret_key(size) do
    1..size
    |> Enum.map(fn _ -> Enum.random(@keys) end)
    |> Enum.join()
  end

  @doc false
  @spec pad(String.t(), integer) :: String.t()
  def pad(data, block_size) do
    to_add = block_size - rem(byte_size(data), block_size)
    data <> to_string(:string.chars(to_add, to_add))
  end

  @doc false
  def aes_encrypt(text, seckey) do
    lv = "0102030405060708"
    :crypto.block_encrypt(:aes_cbc128, seckey, lv, pad(text, 16)) |> Base.encode64()
  end

  @doc false
  def ras_encrypt(text, pubkey, modules) do
    text = text |> String.codepoints() |> Enum.reverse() |> Enum.join()
    bitext = text |> Base.encode16() |> Integer.parse(16) |> elem(0)

    :crypto.mod_pow(bitext, pubkey, modules) |> Base.encode16(case: :lower)
    |> String.pad_leading(256, "0")
  end

  @doc false
  def encrypt(obj, seckey \\ create_secret_key(16)) do
    {:ok, text} = Poison.encode(obj)

    enc_text = text |> aes_encrypt(@nonce) |> aes_encrypt(seckey)
    enc_seckey = ras_encrypt(seckey, @pubkey, @modules)
    [{"params", enc_text}, {"encSecKey", enc_seckey}]
  end
end
