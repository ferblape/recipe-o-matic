class RecipesController < ApplicationController
  def index
    recipes = Recipe

    if searching?
      recipes = recipes.search(params[:q])
    end
    @recipes = recipes.sorted_by_creation
  end

  def show
    @recipe = Recipe.find params[:id]
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe_params = params.require(:recipe).permit(:original_url)

    if recipe_params[:original_url].present?
      @recipe = Recipe.build_from_url(recipe_params[:original_url])
      redirect_to recipe_path(@recipe) and return
    else
      flash[:alert] = t('.empty_url')
      redirect_to new_recipe_path
    end
  rescue RecipeFetcher::Base::NoAdapter
    flash[:alert] = t('.no_adapter', url: recipe_params[:original_url]).html_safe
    redirect_to new_recipe_path
  end
end
