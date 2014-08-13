class AddMetadataToRecipes < ActiveRecord::Migration
  def up
    execute "CREATE EXTENSION IF NOT EXISTS hstore"

    add_column :recipes, :metadata, :hstore
  end

  def down
    execute "DROP EXTENSION IF EXISTS hstore"

    remove_column :recipes, :metadata
  end
end
