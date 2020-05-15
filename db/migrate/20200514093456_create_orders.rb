class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :member, foreign_key: true, null: false
      t.integer :order_status, default: 0
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :postage, default: 800
      t.integer :payment_method, default: 0
      t.integer :billing_amount, null: false

      t.timestamps
    end
  end
end
