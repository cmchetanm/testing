class Transaction < ApplicationRecord
  belongs_to :merchant

  enum status: [:processed, :error]
end
