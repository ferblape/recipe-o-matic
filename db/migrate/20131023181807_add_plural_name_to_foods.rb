class AddPluralNameToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :plural_name, :string

    add_index :foods, :name
    add_index :foods, :plural_name
  end
end
