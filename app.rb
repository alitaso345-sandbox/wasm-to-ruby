module Internal
  UNKNOWN_ID = 0
  TYPE_ID = 1
  IMPORT_ID = 2
  FUNCTION_ID = 3
  TABLE_ID = 4
  MEMORY_ID = 5
  GLOBAL_ID = 6
  EXPORT_ID = 7
  START_ID = 8
  ELEMENT_ID = 9
  CODE_ID = 10
  DATA_ID = 11

  Representation = Struct.new(
    :version
  )
end

class Parse
  include Internal

  attr_reader :io

  def initialize(io)
    @io = io
  end

  def parse
    magic_number = read_magic
    version =  read_version

    puts "MagicNumber: #{magic_number}"
    puts "version: #{version}"

    rep = Representation.new(:version)

    loop do
      break if io.eof?
      read_section(rep)
    end
  end

  private

  def read_bytes(n)
    io.read(n)
  end

  def read_magic
    read_bytes(4)
  end

  def read_version
    read_uint32
  end

  def read_section(rep)
    id = read_varuint
    payload_len = read_varuint

    case id
    when TYPE_ID
      # TODO implement
    when IMPORT_ID
    when FUNCTION_ID
    when TABLE_ID
    when MEMORY_ID
    when GLOBAL_ID
    when EXPORT_ID
    when START_ID
    when ELEMENT_ID
    when CODE_ID
    when DATA_ID
    end
  end

  def read_uint8
    read_bytes(1).ord
  end
  def read_uint32
    read_bytes(4).unpack('V')[0]
  end

  # https://en.wikipedia.org/wiki/LEB128#Decode_unsigned_integer
  def read_varuint
    result = 0
    shift = 0
    loop do
      byte = read_uint8

      # 論理和を取ることで下位7bitを取得することができる
      # 7bitズラしてshiftすることで、リトルエンディアンの逆操作をしている
      result |= (byte & 0b0111_1111) << shift

      # 論理和を取って0になるということは、最上位bitが0ということ
      # これは終わりの合図
      break if (byte & 0b1000_0000) == 0
      shift += 7
    end

    result
  end
end

binary = IO.binread('./hello.wasm')
io = StringIO.new(binary)
Parse.new(io).parse

