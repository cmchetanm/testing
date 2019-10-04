module Api
  module V1
    class TransactionSerializer < ActiveModel::Serializer
      attributes :id, :amount, :status
      belongs_to :merchant, serializer: MerchantSerializer
    end
  end
end

