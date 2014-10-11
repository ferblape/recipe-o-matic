class List < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :list_entries, -> { order('position ASC') }
  has_many :recipes, through: :list_entries

  scope :sorted_by_creation, -> { order('created_at DESC') }
  scope :last_created, -> { sorted_by_creation.limit(5) }

  def ingredients
    ingredients_table = {}

    recipes.includes(:ingredients).map(&:ingredients).flatten.group_by(&:food).each do |food, ingredients|
      ingredients_table[food.name] ||= {}
      ingredients.each do |ingredient|
        unit = ingredient.unit || ''
        ingredients_table[food.name][unit] ||= 0
        ingredients_table[food.name][unit] += ingredient.amount if ingredient.amount
      end
    end

    ingredients_table.map do |food_name, units_and_amounts|
      units_and_amounts.map do |unit, amount|
        [amount, unit, food_name]
      end.flatten
    end
  end
end
