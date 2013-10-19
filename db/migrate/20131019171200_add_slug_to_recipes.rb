class AddSlugToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :slug, :string
    add_index :recipes, :slug, unique: true

    Recipe.all.each do |recipe|
      recipe.save
    end
  end
end
