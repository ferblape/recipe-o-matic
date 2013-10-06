class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :original_url
      t.text :text
      t.integer :state, default: 0
      t.string :image
      t.timestamps
    end

    add_index :recipes, :state
  end
end
