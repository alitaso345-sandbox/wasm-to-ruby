class Parse
  def initialize(io)
    @io = io
  end

  def parse
    magic_number = read_magic
    version =  read_version

    puts "MagicNumber: #{magic_number}"
    puts "version: #{version}"
  end

  private

  def read_bytes(n)
    @io.read(n)
  end

  def read_magic
    read_bytes(4)
  end

  def read_version
    read_uint32
  end

  def read_uint32
    read_bytes(4).unpack('V')[0]
  end
end

binary = IO.binread('./hello.wasm')
io = StringIO.new(binary)
Parse.new(io).parse

