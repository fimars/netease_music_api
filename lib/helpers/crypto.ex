defmodule Helpers.Crypto do
  # 常量
  # 参考 https://github.com/darknessomi/musicbox/wiki/
  @modules "00e0b509f6259df8642dbc35662901477df22677ec152b5ff68ace615bb7b725152b3ab17a876aea8a5aa76d2e417629ec4ee341f56135fccf695280104e0312ecbda92557c93870114af6c9d05c4f7f0c3685b7a46bee255932575cce10b424d813cfe4875d3e82047b97ddef52741d546b8e289dc6935b3ece0462db0a22b8e7"
  @nonce "0CoJUm6Qyw8W8jud"
  @pubKey "010001"
  @keys "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" |> String.codepoints
  

  def env do
    [@modules, @nonce, @pubKey]
  end

  def create_secret_key(size) do
    1..size
    |> Enum.map(fn _ -> Enum.random(@keys) end)
    |> Enum.join()
  end

  @doc """
  Padding need encrypt data.
  """
  @spec pad(t, integer) :: t
  def pad(data, block_size) do
    to_add = block_size - rem(byte_size(data), block_size)
    data <> to_string(:string.chars(to_add, to_add))
  end
  

  def aes_encrypt(text, secKey) do
    lv = "0102030405060708"
    # 历史性的一刻
    :crypto.block_encrypt(:aes_cbc128, secKey, lv, pad(text, 16))
    # const _text = text
    # const lv = new Buffer('0102030405060708', 'binary')
    # const _secKey = new Buffer(secKey, 'binary')
    # const cipher = crypto.createCipheriv('AES-128-CBC', _secKey, lv)
    # let encrypted = cipher.update(_text, 'utf8', 'base64')
    # encrypted += cipher.final('base64')
    # return encrypted
  end

  def encrypt(obj) do
    text = Poison.encode(%{ "obj" => obj })
    seckey = create_secret_key(16)
    enctext = text |> aes_encrypt(@nonce) |> aes_encrypt(seckey)
    # function Encrypt(obj) {
    #   const text = JSON.stringify(obj)
    #   const secKey = createSecretKey(16)
    #   const encText = aesEncrypt(aesEncrypt(text, nonce), secKey)
    #   const encSecKey = rsaEncrypt(secKey, pubKey, modulus)
    #   return {
    #     params: encText,
    #     encSecKey: encSecKey
    #   }
    # }
  end
end