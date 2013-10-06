class Admin::RecipesController < ApplicationController
  layout 'admin'

  before_filter :load_recipe, only: [:new, :edit, :update]
  before_filter :build_ingredients, only: [:new, :edit]

  def index
    redirect_to edit_admin_recipe_path(Recipe.sorted_by_creation.first)
  end

  def new
    build_image
  end

  def create
    @recipe = Recipe.new recipe_params
    if @recipe.save
      redirect_to edit_admin_recipe_path(@recipe), notice: t('.success')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update_attributes recipe_params
      redirect_to edit_admin_recipe_path(@recipe), notice: t('.success')
    else
      render 'edit'
    end
  end

  private

  def load_recipe
    @recipe = params[:id].present? ? Recipe.find(params[:id]) : Recipe.new
  end

  def recipe_params
    params.require(:recipe).permit(:name, :text, :original_url, {images: []}, :state,
                                   ingredients_attributes: [ :amount, :unit, :food_name, :text, :id, :_destroy ])
  end

  def build_image
    @recipe.images = ['']
  end

  def build_ingredients
    if @recipe.ingredients.any?
      @recipe.ingredients.build
    else
      10.times { @recipe.ingredients.build }
    end
  end
end
