class Recipe < ActiveRecord::Base
  include State

  has_many :ingredients

  def self.build_from_url(url)
    fetcher = RecipeFetcher::Base.new(url)

    recipe = Recipe.new text: fetcher.text
    recipe.images = fetcher.images
    recipe.save!

    fetcher.ingredients.each do |str|
      Ingredient.build_from_raw(str, recipe)
    end

    recipe
  end
end
