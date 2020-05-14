class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :member, foreign_key: true, null: false
      t.integer :order_status, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :postage, null: false
      t.integer :payment_method, null: false
      t.integer :billing_amount, null: false

      t.timestamps
    end
  end
end
