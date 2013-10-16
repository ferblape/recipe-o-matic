module RecipesHelper
  def state(recipe)
    t(".#{Recipe::STATES.invert[recipe.state]}")
  end

  def ingredients_summary(recipe)
    max = 5
    ingredients = recipe.ingredients
    ingredients_count = recipe.ingredients.size
    str = recipe.ingredients[0..max].map(&:food).map(&:name).join(', ')

    ingredients_count > max ? str + '…' : str
  end

  def split_in_two_groups(group)
    size = group.size

    [group[0..size/2], group[((size/2)+1)..-1]]
  end
end
