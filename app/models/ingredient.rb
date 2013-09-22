class Ingredient < ActiveRecord::Base
  include State

  belongs_to :recipe
  belongs_to :food

  def self.build_from_raw(recipe, str)
    amount, unit, food_name = TextToIngredientProcessor.process(str, Food)

    recipe.ingredients.new do |ingredient|
      ingredient.text   = str
      ingredient.amount = amount
      ingredient.unit   = unit
      ingredient.food   = food
      ingredient.save!
    end
  end
end
