class RecipesController < ApplicationController
  def index
    @recipes = Recipe.published.sorted_by_creation
  end

  def show
    @recipe = Recipe.find params[:id]
  end
end
