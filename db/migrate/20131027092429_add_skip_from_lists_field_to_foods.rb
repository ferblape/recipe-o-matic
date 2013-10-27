class AddSkipFromListsFieldToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :skip_from_lists, :boolean, default: false

    add_index :foods, :skip_from_lists
  end
end
