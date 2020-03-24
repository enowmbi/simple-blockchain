class Blockchain

  require_relative 'block'
  require_relative 'transaction'

  attr_reader :chain

  def initialize
    @chain = []
    #initialize with genesis block
    create_genesis_block
  end

  def create_genesis_block
    #create a new block with manually set values and then push it to the chain
    genesis_block = Block.new(Time.now(),Transaction.new("","",0))   
    genesis_block.previous_hash ='0'
    genesis_block.hash = genesis_block.calculate_hash()
    @chain << genesis_block
  end

  def add_block(block)
    #get the hash of the previous block and also compute the hash of the current block
    block.previous_hash = get_lattest_block.hash
    block.hash = block.calculate_hash()
    @chain << block
  end


  def get_lattest_block
    return @chain[@chain.length - 1] 
  end

  def valid?
    #iterate through the blockchain and
    return true if @chain.length == 1
    @chain.each_with_index do |block,index|
      begin
        new_index = index + 1
        current_block = @chain[new_index]
        previous_block = @chain[new_index - 1]
        return false if current_block.hash != current_block.calculate_hash()
        return false if current_block.previous_hash != previous_block.hash
      rescue
        return false
      end
      return true
    end
  end

  def calculate_balance(address_of_wallet)
    total_coins_received = 0
    total_coins_sent = 0
    @chain.each do |block|
      if block.transaction.address_of_receiver == address_of_wallet
        total_coins_received += block.transaction.amount
      elsif block.transaction.address_of_sender == address_of_wallet
        total_coins_sent += block.transaction.amount
      end
    end
    total = total_entries - total_exits
    return total
  end
end
