module RecipesHelper
  def state(recipe)
    t(".#{Recipe::STATES.invert[recipe.state]}")
  end

  def ingredients_summary(recipe)
    max = 5
    ingredients = recipe.ingredients
    ingredients_count = ingredients.count
    str = ingredients.limit(max).map(&:food).map(&:name).join(', ')

    ingredients_count > max ? str + '…' : str
  end
end
