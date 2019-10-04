class Transactions::Create < Mutations::Command
  # These inputs are required
  required do
    integer :merchant_id
    string :amount
  end

  optional do
    string :status
  end

  # The execute method is called only if the inputs validate. It does your business action.
  def execute
    merchant = Merchant.find(inputs[:merchant_id])

    transaction = merchant.transactions.create(inputs.except(:merchant_id))

    transaction
  end
end
