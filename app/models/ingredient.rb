class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :food, autosave: true

  def self.build_from_raw(raw_string)
    ingredient = TextToIngredientProcessor.new(raw_string, Ingredient.new).process
  end

  def food_name=(value)
    if food
      food.name = value
    else
      self.food = Food.find_or_initialize_by_name(value)
    end
  end
end
