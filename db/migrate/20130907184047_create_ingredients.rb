class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.references :recipe
      t.references :food
      t.string :text
      t.float :amount
      t.string :unit
      t.integer :state, default: 0
      t.timestamps
    end

    add_index :ingredients, :state
    add_index :ingredients, :recipe_id
    add_index :ingredients, :food_id
  end
end
