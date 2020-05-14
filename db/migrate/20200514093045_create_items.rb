class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true, null: false
      t.string :name, null: false
      t.text :explanation, null: false
      t.integer :price, null: false
      t.boolean :is_saled, null: false
      t.string :item_image_id, null: false

      t.timestamps
    end
  end
end
