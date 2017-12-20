defmodule Helpers.Crypto do
  # 常量
  # 参考 https://github.com/darknessomi/musicbox/wiki/
  @modules "00e0b509f6259df8642dbc35662901477df22677ec152b5ff68ace615bb7b725152b3ab17a876aea8a5aa76d2e417629ec4ee341f56135fccf695280104e0312ecbda92557c93870114af6c9d05c4f7f0c3685b7a46bee255932575cce10b424d813cfe4875d3e82047b97ddef52741d546b8e289dc6935b3ece0462db0a22b8e7"
  @nonce "0CoJUm6Qyw8W8jud"
  @pubKey "010001"

  def env do
    [@modules, @nonce, @pubKey]
  end

  def encrypt do
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