# require blockchain.rb -- has all references to the libraries

require_relative 'blockchain'

# create an instance of the blockchain with genesis block
blockchain = Blockchain.new
puts "Blockchain initialized with a genesis block... "
# get the number of blocks on the chain
puts "Number of blocks on the chain: #{blockchain.chain.length}"

# check the validity of the blockchain
puts "blockchain is: #{blockchain.valid? ? 'valid' : 'invalid'}"

1.upto(10) do
  # create a new transaction
  transaction = Transaction.new('Enow', 'Oben', 20)
  blockchain.add_transaction_to_pending_transactions(transaction)

  # add the transaction to pending transaction
  blockchain.add_transaction_to_pending_transactions(transaction)

  # mine the pending transactions
  blockchain.mine_pending_transactions('xavier')

  # check the validity of the blockchain
  puts "blockchain is: #{blockchain.valid? ? 'valid' : 'invalid'}"
end
# check the balance
puts "=================================================="
puts "Your balance is #{blockchain.get_balance('Aspen')}"
puts "=================================================="
puts "Enow's balance is #{blockchain.get_balance('Enow')}"
puts "=================================================="
puts "Oben's balance is #{blockchain.get_balance('Oben')}"
puts "=================================================="
puts "Xavier's balance is #{blockchain.get_balance('Xavier')}"
puts "=================================================="
