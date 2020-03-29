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
    self.chain << genesis_block
  end

  def mine_pending_transactions(mining_reward_address)
    temp_holding_for_pending_transactions = []
    self.pending_transactions.each do |trans|
      temp_holding_for_pending_transactions << trans
    end
    self.pending_transactions.clear

    puts "these are the transactions that are pending: #{temp_holding_for_pending_transactions}"
    puts "the original pending_transaction: #{self.pending_transactions}"

    new_block = Block.new(Time.now(),temp_holding_for_pending_transactions)
    puts "this is the new block #{new_block.inspect}"
    new_block.previous_hash = get_lattest_block.hash
    new_block.mine_block(self.difficulty)
    self.chain << new_block

    # add transaction on the blockchain to reward miner
    add_transaction_to_pending_transactions(Transaction.new(nil,mining_reward_address,@mining_reward))

    #remove the processed transaction the the block
    # self.pending_transactions.clear
  end

  def add_transaction_to_pending_transactions(transaction)
    # return "Address of receiver and Address of sender must not be empty" if !transaction.address_of_sender || !transaction.address_of_receiver
    # return "Can not add invalid transaction" if !transaction.valid?
    self.pending_transactions << transaction
  end

  def get_lattest_block
    return self.chain[self.chain.length - 1] 
  end

  def valid?
    return true if self.chain.length == 1
    self.chain.each_with_index do |block,index|
      begin
        new_index = index + 1
        current_block = self.chain[new_index]
        previous_block = self.chain[new_index - 1]
        return false if !current_block.has_valid_transactions?
        return false if current_block.hash != current_block.calculate_hash()
        return false if current_block.previous_hash != previous_block.hash
      rescue
        return false
      end
      return true
    end
  end

  def calculate_balance(wallet_address)
    balance = 0
    coins_received =0
    coins_sent =0
    if self.chain.length > 1
      index_of_last_mined_block_on_chain = self.chain.length - 1
      index_of_first_mined_block_on_chain = 1

      index_of_first_mined_block_on_chain.upto(index_of_last_mined_block_on_chain) do |index_of_block|
        block = self.chain[index_of_block]
        index_of_last_transaction_on_block = block.transactions.count - 1
        0.upto(index_of_last_transaction_on_block) do |index_of_transaction|
          transaction = block.transactions[index_of_transaction]
          if transaction.address_of_receiver == wallet_address
            coins_received += transaction.amount
          end
          if transaction.address_of_sender == wallet_address
            coins_sent += transaction.amount
          end
        end
      balance = coins_received - coins_sent
      return balance
      end
    else
      return 0
    end

  end

end
