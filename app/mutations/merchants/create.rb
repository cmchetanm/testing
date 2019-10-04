class Merchants::Create < Mutations::Command
  # These inputs are required
  required do
    string  :email
    string  :name
  end

  # These inputs are optional
  optional do
    string  :description
    string  :status
  end

  # The execute method is called only if the inputs validate. It does your business action.
  def execute
    merchant = Merchant.create!(inputs)
    
    merchant
  end
end
