class CreateListEntries < ActiveRecord::Migration
  def change
    create_table :list_entries do |t|
      t.references :list
      t.references :recipe
      t.integer :position
      t.timestamps
    end

    add_index :list_entries, [:list_id, :recipe_id], unique: true
  end
end
