class Transactions::Update < Mutations::Command
  # These inputs are required
  required do
    string :id
  end

  # These inputs are optional
  optional do
    string :amount
    integer :status
  end

  # The execute method is called only if the inputs validate. It does your business action.
  def execute
    transaction = Transaction.find(inputs[:id])
    
    transaction.update_attributes(inputs.except(:id))

    transaction
  end
end