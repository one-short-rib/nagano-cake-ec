class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true
      t.string :name
      t.text :explanation
      t.integer :price
      t.boolean :is_saled
      t.string :item_image_id

      t.timestamps
    end
  end
end
