class Blockchain

  require_relative 'block'
  require_relative 'transaction'

  attr_reader :chain, :difficulty, :pending_transactions

  def initialize
    @chain = []
    @difficulty = 2
    @pending_transactions =[]
    @mining_reward = 100
    #initialize with genesis block
    create_genesis_block
  end

  def create_genesis_block
    #create a new block with manually set values and then push it to the chain
    genesis_block = Block.new(Time.now(),Transaction.new(nil,nil,0))   
    genesis_block.previous_hash ='0'
    genesis_block.hash = genesis_block.calculate_hash()
    @chain << genesis_block
  end

  def mine_pending_transactions(mining_reward_address)
    new_block = Block.new(Time.now(),@pending_transactions.first)
    new_block.previous_hash = get_lattest_block.hash
    new_block.mine_block(@difficulty)
    @chain << new_block
    #remove the processed transaction the the block
    @pending_transactions.shift
    # add transaction on the blockchain to reward miner
    create_pending_transaction_on_blockchain(Transaction.new(nil,mining_reward_address,@mining_reward))
  end

  def create_pending_transaction_on_blockchain(transaction)
    @pending_transactions << transaction
  end

=begin
  def add_block(block)
    #get the hash of the previous block and also compute the hash of the current block
    block.previous_hash = get_lattest_block.hash
    block.mine_block(@difficulty)
    @chain << block
  end
=end


  def get_lattest_block
    return @chain[@chain.length - 1] 
  end

  def valid?
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

  def calculate_balance(wallet_address)
    total_coins_received = 0
    total_coins_sent = 0
    @chain.each do |block|
      if block.transaction.address_of_receiver == wallet_address
        total_coins_received += block.transaction.amount
      elsif block.transaction.address_of_sender == wallet_address
        total_coins_sent += block.transaction.amount
      end
    end
    total = total_coins_received - total_coins_sent
    return total
  end
end
