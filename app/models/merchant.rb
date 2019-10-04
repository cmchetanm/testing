class Merchant < ApplicationRecord
  has_many :transactions, dependent: :destroy

  enum status: [:inactive, :active]
end
