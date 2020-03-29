require 'openssl'

class KeyGenerator

  attr_reader :key_pair, :private_key, :public_key

  def initialize
    ec = OpenSSL::PKey::EC.new('secp256k1')
    @key_pair = ec.generate_key!
    puts "generated key: #{self.key_pair}"
    @private_key = self.key_pair.private_key
    @public_key = self.key_pair.public_key
  end
end
