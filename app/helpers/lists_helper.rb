module ListsHelper
  def format_list_ingredients(list_ingredients)
    result = ""
    list_ingredients.each do |list_ingredient|
      presenter = IngredientPresenter.new(list_ingredient)
      presenter.to_list_ingredient.each do |ingredient|
        result += content_tag(:li) { ingredient }
      end
    end

    result.html_safe
  end
end
