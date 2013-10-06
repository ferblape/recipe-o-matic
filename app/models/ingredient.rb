class Ingredient < ActiveRecord::Base
  include State

  belongs_to :recipe
  belongs_to :food, autosave: true

  SUPPORTED_UNITS = [
    'gr', 'g',
    'kg', 'mg',
    'ml', 'l',
    'puñado', 'trozo',
    'cucharada',
    'cucharada pequeña',
    'pequeña',
    'grande',
    'taza', 'copa',
    'grano', 'hoja',
    'pastilla'
  ]

  def self.build_from_raw(str, recipe)
    processor = TextToIngredientProcessor.new(str)
    processor.process!

    recipe.ingredients.new do |ingredient|
      ingredient.text   = processor.text.downcase
      ingredient.amount = processor.amount
      ingredient.unit   = processor.unit
      ingredient.food   = Food.find_or_create_by(name: processor.food_name)
      ingredient.save!
    end
  end

  def food_name=(value)
    if food
      food.name = value
    else
      build_food name: value
    end
  end
end
