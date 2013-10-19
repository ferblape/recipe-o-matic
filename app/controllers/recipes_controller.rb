class RecipesController < ApplicationController
  def index
    recipes = Recipe

    if params[:food_id]
      @food = Food.find(params[:food_id])
      recipes = @food.recipes
    elsif searching?
      recipes = recipes.search(params[:term])
    end

    @recipes = recipes.includes(ingredients: :food).sorted_by_creation

    respond_to do |format|
      format.html
      format.json do
        render json: @recipes.to_json
      end
    end
  end

  def show
    @recipe = Recipe.where(slug: params[:id]).first
  end

  def suggestion
    slug = Recipe.pluck(:slug).to_a.shuffle.first

    redirect_to action: :show, id: slug
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
  rescue => e
    flash[:alert] = e.message
    if @recipe && !@recipe.new_record?
      redirect_to recipe_path(@recipe)
    else
      redirect_to new_recipe_path
    end
  end
end
