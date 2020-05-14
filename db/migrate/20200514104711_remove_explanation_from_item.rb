class RemoveExplanationFromItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :explanation, :text
  end
end
