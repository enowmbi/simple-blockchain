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

#check the validity of the blockchain
puts "blockchain is: #{blockchain.valid? ? 'valid':'invalid'}" 

#check the balance 
puts "Your balance is #{blockchain.calculate_balance(wallet_address)}"



