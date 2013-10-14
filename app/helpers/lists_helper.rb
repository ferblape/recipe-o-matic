module ListsHelper
  def format_list_ingredient(list_ingredient)
    presenter = IngredientPresenter.new(*list_ingredient)
    presenter.to_list_ingredient
  end
end
