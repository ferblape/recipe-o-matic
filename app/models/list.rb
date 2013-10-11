class List < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :list_entries, -> { order('position ASC') }
  has_many :recipes, through: :list_entries

  def ingredients
    ingredients_table = {}

    recipes.includes(:ingredients).map(&:ingredients).flatten.group_by(&:food).each do |food, ingredients|
      ingredients_table[food.name] ||= {}
      ingredients.each do |ingredient|
        unit = ingredient.unit || ''
        ingredients_table[food.name][unit] ||= 0
        ingredients_table[food.name][unit] += ingredient.amount
      end
    end

    ingredients_table.map do |food_name, row|
      row.map do |unit, amount|
        [food_name, unit, amount]
      end.flatten
    end
  end
end
