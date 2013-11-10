class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :food, autosave: true

  def self.build_from_raw(str, recipe)
    processor = TextToIngredientProcessor.new(str)
    processor.process!

    recipe.ingredients.build do |ingredient|
      ingredient.text      = processor.text.downcase
      ingredient.amount    = processor.amount
      ingredient.unit      = processor.unit
      ingredient.food_name = processor.food_name
    end
  end

  def food_name=(value)
    if food
      food.name = value
    else
      self.food = Food.find_or_initialize_by_name(value)
    end
  end
end
