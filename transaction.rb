class Transaction
  require_relative 'key_generator'

  attr_reader :address_of_sender, :address_of_receiver,:amount,:signature

  def initialize(address_of_sender,address_of_receiver,amount)
    @address_of_sender = address_of_sender
    @address_of_receiver = address_of_receiver
    @amount = amount
  end

  def calculate_hash
    payload = @address_sender.to_s + @address_of_receiver.to_s +  @amount.to_s
    Digest::SHA256.hexdigest(payload)
  end

  def sign_transaction(signing_key)
    if signing_key.public_key.to_octet_string(:compressed) != @address_of_sender
      return false
    end
    hash_of_transaction = calculate_hash()
    @signature = signing_key.sign(OpenSSL::Digest::SHA256.new,hash_of_transaction)
  end

  def valid? 
    # puts "address of sender : #{@address_of_sender.to_octet_string(:compressed)}"
    return true if !@address_of_sender && @address_of_receiver && @amount > 0   #for mining reward transaction
    return false if @address_of_sender && @address_of_sender.length == 0
    return true
    # ec = KeyGenerator.new()
    # ec.verify(OpenSSL::Digest::SHA256.new,@signature,@address_of_sender)
  end
end
