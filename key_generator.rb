require 'openssl'

class KeyGenerator
  attr_reader :key, :private_key, :public_key
  def initialize
    ec = OpenSSL::PKey::EC.new('secp256k1')
    @key = ec.generate_key()
    puts "generated key: #{@key}"
    @private_key = @key.private_key
    @public_key = @key.public_key
    puts "private key: #{@private_key}"
    puts "public key: #{@public_key}"
  end
end
