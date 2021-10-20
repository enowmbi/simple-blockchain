# frozen_string_literal: true

require_relative 'key_generator'

# Handles mining transactions
class Transaction
  attr_reader :address_of_sender, :address_of_receiver, :amount, :signature

  def initialize(address_of_sender, address_of_receiver, amount)
    @address_of_sender = address_of_sender
    @address_of_receiver = address_of_receiver
    @amount = amount
  end

  def calculate_hash
    payload = @address_sender.to_s + @address_of_receiver.to_s + @amount.to_s
    Digest::SHA256.hexdigest(payload)
  end

  def sign_transaction(signing_key)
    raise "You can't sign transactions for other wallets" unless public_key_equals_address_of_sender

    hash_of_transaction = calculate_hash
    signature = signing_key.sign(OpenSSL::Digest::SHA256.new, hash_of_transaction)
    signature
  end

  def valid?
    return true if !address_of_sender || (address_of_receiver && amount.positive?) # for mining reward transaction

    return false if @address_of_sender && @address_of_sender.empty?

    true
    # ec = KeyGenerator.new()
    # ec.verify(OpenSSL::Digest::SHA256.new,@signature,@address_of_sender)
  end

  private

  def public_key_equals_address_of_sender
    signing_key.public_key.to_bn.to_s == address_of_sender
  end
end
