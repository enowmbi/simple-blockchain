class Transaction
  attr_reader :address_of_sender, :address_of_receiver,:amount
  def initialize(address_of_sender,address_of_receiver,amount)
      @address_of_sender = address_of_sender
      @address_of_receiver = address_of_receiver
      @amount = amount
  end
end
