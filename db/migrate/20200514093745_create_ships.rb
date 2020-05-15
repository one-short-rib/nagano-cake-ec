class CreateShips < ActiveRecord::Migration[5.2]
  def change
    create_table :ships do |t|

      t.integer :member_id, :null => false
      t.string :postal_code, :null => false
      t.string :address, :null => false
      t.string :name, :null => false

      t.timestamps
    end
  end
end
