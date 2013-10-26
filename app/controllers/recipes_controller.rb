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

  def new_form
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new recipe_params

    if creating_recipe_by_url?
      @recipe = Recipe.build_from_url(recipe_params[:original_url])
      redirect_to recipe_path(@recipe) and return
    else
      if @recipe.save
        redirect_to recipe_path(@recipe) and return
      else
        flash.now[:alert] = @recipe.errors.full_messages.to_sentence
        render 'new_form'
      end
    end
  rescue RecipeFetcher::Base::NoAdapter
    flash[:alert] = t('.no_adapter', url: recipe_params[:original_url]).html_safe
    redirect_to new_recipe_path
  rescue => e
    flash[:alert] = e.message
    redirect_to (@recipe && !@recipe.new_record?) ? recipe_path(@recipe) : new_recipe_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :text, :original_url, :image, :remote_image_url, :ingredients_text,
                                   ingredients_attributes: [ :amount, :unit, :food_name, :text, :id, :_destroy ])
  end

  def creating_recipe_by_url?
    recipe_params[:original_url].present? && recipe_params[:name].blank?
  end
end
