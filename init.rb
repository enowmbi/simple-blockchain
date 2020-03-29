#require blockchain.rb -- has all references to the libraries

require_relative 'blockchain'

#create an instance of the blockchain with genesis block
blockchain = Blockchain.new
puts "Blockchain initialized with a genesis block... "
#get the number of blocks on the chain
puts "Number of blocks on the chain: #{blockchain.chain.length}"

#create signing keys
ec = OpenSSL::PKey::EC.new('secp256k1')
puts "Elliptic curve created ..."
key= ec.generate_key!
puts "Generated keys - private: #{key.private_key} and public keys: #{key.public_key}"
wallet_address = key.public_key
#create a new transaction
transaction1 = Transaction.new(key.public_key,key.public_key,20)
signature = transaction1.sign_transaction(key)
puts "signature of transaction: #{signature}"

#check the validity of the blockchain
puts "blockchain is: #{blockchain.valid? ? 'valid':'invalid'}" 
#add the transaction to pending transaction
blockchain.add_transaction_to_pending_transactions(transaction1)
#mine the pending transactions
blockchain.mine_pending_transactions(wallet_address)

#get the number of blocks on the chain
puts "Number of blocks on the chain: #{blockchain.chain.length}"

#create a new transaction
transaction = Transaction.new('Enow','Oben',20)
blockchain.add_transaction_to_pending_transactions(transaction)

#check the validity of the blockchain
puts "blockchain is: #{blockchain.valid? ? 'valid':'invalid'}" 

#add the transaction to pending transaction
blockchain.add_transaction_to_pending_transactions(transaction)

#mine the pending transactions
blockchain.mine_pending_transactions('xavier')

#check the validity of the blockchain
puts "blockchain is: #{blockchain.valid? ? 'valid':'invalid'}" 

#check the balance 
puts "Your balance is #{blockchain.calculate_balance(wallet_address)}"
puts "Enow's balance is #{blockchain.calculate_balance('Enow')}"
puts "Oben's balance is #{blockchain.calculate_balance('Oben')}"
puts "Xavier's balance is #{blockchain.calculate_balance('Xavier')}"



#create a new transaction
transaction = Transaction.new('Aspen','Enow',20)
blockchain.add_transaction_to_pending_transactions(transaction)

#check the validity of the blockchain
puts "blockchain is: #{blockchain.valid? ? 'valid':'invalid'}" 

#add the transaction to pending transaction
blockchain.add_transaction_to_pending_transactions(transaction)

#mine the pending transactions
blockchain.mine_pending_transactions('raider miner')

#check the validity of the blockchain
puts "blockchain is: #{blockchain.valid? ? 'valid':'invalid'}" 

#check the balance 
puts "Enow's balance is #{blockchain.calculate_balance('Enow')}"
puts "Oben's balance is #{blockchain.calculate_balance('Oben')}"
puts "Xavier's balance is #{blockchain.calculate_balance('Xavier')}"

puts "Aspen's balance is #{blockchain.calculate_balance('Aspen')}"

puts "Oben's balance is #{blockchain.calculate_balance('raid miner')}"
