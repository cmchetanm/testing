module Api
  module V1
    class MerchantSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :email, :status, :total_transaction_sum
      has_many :transactions, serializer: TransactionSerializer
    end
  end
end
