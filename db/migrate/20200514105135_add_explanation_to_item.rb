class AddExplanationToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :explanation, :string
  end
end
