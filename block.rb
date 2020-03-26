class Block

  require 'digest'

  attr_accessor :previous_hash, :hash, :transaction

  def initialize(timestamp, transaction)
    @timestamp = timestamp
    @transaction = transaction
    @nonce = 0
  end

  def calculate_hash()
    payload = @timestamp.to_s + @data.to_s + @previous_hash.to_s +  @nonce.to_s
    Digest::SHA256.hexdigest(payload)
  end

  def mine_block(difficulty)
    difficulty_string = '0' * difficulty
    @nonce = 0
    loop do 
      @hash = calculate_hash()
      if @hash.start_with?(difficulty_string) 
        puts "Block mined: #{@hash}"
        break
      else
        @nonce +=1
      end
    end

  end

  def has_valid_transactions?
    @transactions.each do |transaction|
      return false if !transaction.valid?
    end
    return true
  end

end

