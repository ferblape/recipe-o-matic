module RecipesHelper
  def state(recipe)
    t(".#{Recipe::STATES.invert[recipe.state]}")
  end
end
