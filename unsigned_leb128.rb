## https://en.wikipedia.org/wiki/LEB128#Decode_unsigned_integer
# unsigned LEB128をデコードする

bytes = [0xA1, 0x86, 0x15]

result = 0
shift = 0

bytes.each do |byte|
  # 0x7Fは0111_1111
  # 論理和を取ることで下位7bitを取得することができる
  # 7bitズラしてshiftすることで、リトルエンディアンの逆操作をしている
  result |= (byte & 0x7F) << shift

  # 0x80は1000_0000
  # 論理和を取って0になるということは、最上位bitが0ということ
  # これは終わりの合図
  break if (byte & 0x80) == 0
  shift += 7
end

p result
