class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :transactions, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :amount
      t.references :merchant, index: true
      t.integer :status, defult: 0
      t.timestamps
    end
  end
end
