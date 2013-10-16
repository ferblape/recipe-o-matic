class AddTextHtmlToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :text_html, :text
  end
end
