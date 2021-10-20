# frozen_string_literal: true

require "digest"

# This class creates/mines a block with necessary information
class Block
  def initialize(timestamp:, transactions:)
    @timestamp = timestamp
    @transactions = transactions
    @nonce = 0
  end

  def mine_block(difficulty)
    difficulty_string = "0" * difficulty
    nonce = 0
    loop do
      hash = calculate_hash
      if hash.start_with?(difficulty_string)
        puts "Block mined: #{hash}"
        break
      else
        nonce += 1
      end
    end
  end

  def valid_transactions?
    transactions.each do |transaction|
      return false unless transaction.valid?
    end
    true
  end

  private

  attr_reader :previous_hash, :hash, :transactions, :nonce

  def calculate_hash
    payload = @timestamp.to_s + @transactions.to_s + @previous_hash.to_s + @nonce.to_s
    Digest::SHA256.hexdigest(payload)
  end
end
