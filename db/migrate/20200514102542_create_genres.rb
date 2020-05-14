class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|

    	t.integer :id, :null => false
    	t.string :name, :null => false
    	t.boolean :is_valid, :null => false
    	t.datetime :created_at, :null => false
    	t.datetime :updated_at, :null => false

      t.timestamps
    end
  end
end
