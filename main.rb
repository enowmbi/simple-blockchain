require_relative 'blockchain'
blockchain = Blockchain.new
puts "Blockchain initialized with a genesis block... "
puts "Details of the genesis block:"
puts blockchain.inspect
puts "Number of blocks on the chain: #{blockchain.chain.length}"

puts "creating a new block and adding to the blockchain"

lattest_block = blockchain.get_lattest_block
puts "this is my lattest block: #{lattest_block}"
previous_hash =  lattest_block.hash
puts "this is the previous hash: #{previous_hash}"
data = "Amount: 2000,from: xxxxxxx,to:yyyyyy"
puts "my new data is: #{data}"
block =  Block.new(Time.now(), data,previous_hash)
puts "My new block has the following details: #{block}"
puts "My new block has the following details: #{block.inspect}"
blockchain.add_block(block)
puts "A new block has been created with the following details and added to the blockchain"
puts "this is the raw block : #{block}"
puts "This is the lattest block #{blockchain.get_lattest_block}"
puts "The new length of the blockchain is now #{blockchain.chain.length}"


