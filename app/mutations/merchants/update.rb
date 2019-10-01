class Merchants::Update < Mutations::Command
  # These inputs are required
  required do
    integer :id
  end

  # These inputs are optional
  optional do
    string  :name
    string  :description
    integer :status
  end

  # The execute method is called only if the inputs validate. It does your business action.
  def execute
    merchant = Merchant.find(inputs[:id])
    
    merchant.update_attributes(inputs.except(:id))

    merchant
  end
end