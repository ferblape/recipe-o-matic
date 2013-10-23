class RemoveStateFromRecipes < ActiveRecord::Migration
  def change
    remove_index :recipes, name: "index_recipes_on_state"
    remove_column :recipes, :state
  end
end
