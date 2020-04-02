require 'openssl'

class KeyGenerator

  ADDRESS_VERSION = '00'
  attr_reader :key_pair, :private_key_hex, :public_key_hex, :private_key, :public_key

  def initialize
    elliptic_curve = OpenSSL::PKey::EC.new('secp256k1')
    @key_pair = elliptic_curve.generate_key
    puts "generated key: #{self.key_pair}"
    @private_key = self.key_pair.private_key
    @public_key = self.key_pair.public_key
    #store hex values of private and public keys
    @private_key_hex = self.key_pair.private_key.to_s(16)
    @public_key_hex = self.key_pair.public_key.to_bn.to_s(16)
  end

  def public_key_hash(hex)
    ripemd(sha256(hex))
  end

  def generate_address(pub_key_hash)
    pk = ADDRESS_VERSION + pub_key_hash
    encode_base58(pk + checksum(pk))
  end

  private 
  def encode_base58(hex)
    leading_zero_bytes = (hex.match(/^([0]+)/) ? $1 : '').size / 2
    ("1"*leading_zero_bytes) + int_to_base58( hex.to_i(16) )
  end

  def ripemd(hex)
    Digest::RMD160.hexdigest([hex].pack("H*"))
  end

  def sha256(hex)
    Digest::SHA256.hexdigest([hex].pack("H*"))
  end

  # checksum is first 4 bytes of sha256-sha256 hexdigest.
  def checksum(hex)
    sha256(sha256(hex))[0...8]
  end

  def int_to_base58(int_val, leading_zero_bytes=0)
    alpha = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
    base58_val, base = '', alpha.size
    while int_val > 0
      int_val, remainder = int_val.divmod(base)
      base58_val = alpha[remainder] + base58_val
    end
    base58_val
  end
end
