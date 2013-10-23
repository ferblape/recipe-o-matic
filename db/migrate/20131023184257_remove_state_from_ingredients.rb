class RemoveStateFromIngredients < ActiveRecord::Migration
  def change
    remove_index :ingredients, name: "index_ingredients_on_state"
    remove_column :ingredients, :state
  end
end
