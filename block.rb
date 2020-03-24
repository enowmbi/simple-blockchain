class Block
  
  require 'digest'

  attr_reader :data
  attr_accessor :previous_hash, :hash, :transaction

  def initialize(timestamp, transaction)
    @timestamp = timestamp
    @transaction = transaction
  end

  def calculate_hash()
    payload = @timestamp.to_s + @data.to_s + @previous_hash.to_s
    Digest::SHA256.hexdigest(payload)
  end

end

