class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :name
      t.text :description
      t.string :email
      t.integer :status, defult: 0
      t.float :total_transaction_sum

      t.timestamps
    end
  end
end
