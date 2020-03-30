require 'openssl'

class KeyGenerator

  attr_reader :key_pair, :private_key, :public_key

  def initialize
    elliptic_curve = OpenSSL::PKey::EC.new('secp256k1')
    @key_pair = elliptic_curve.generate_key
    puts "generated key: #{self.key_pair}"
    #store hex values of private and public keys
    @private_key = self.key_pair.private_key.to_s(16)
    @public_key = self.key_pair.public_key.to_bn.to_s(16)
  end
end
