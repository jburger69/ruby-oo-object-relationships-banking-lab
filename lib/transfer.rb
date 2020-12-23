require 'pry'

class Transfer

  attr_reader :sender, :receiver, :status, :amount

  def initialize(sender,receiver, status = 'pending', amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @sender.balance >= @amount && @status == "pending" && self.valid?
      @sender.deposit(@amount*-1)
      @receiver.deposit(@amount)
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete" || @status == "rejected"
      @sender.deposit(amount)
      @receiver.deposit(amount*-1)
      @status = "reversed"
    end
  end
end
