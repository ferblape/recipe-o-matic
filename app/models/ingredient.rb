class Ingredient < ActiveRecord::Base
  include State

  belongs_to :recipe
  belongs_to :food

  def self.build_from_raw(recipe, str)
    processor = TextToIngredientProcessor.new(str)
    processor.process!

    recipe.ingredients.new do |ingredient|
      ingredient.text   = str
      ingredient.amount = processor.amount
      ingredient.unit   = processor.unit
      ingredient.food   = Food.find_or_create_by(name: processor.food_name)
      ingredient.save!
    end
  end
end
