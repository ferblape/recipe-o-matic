class Admin::RecipesController < ApplicationController
  layout 'admin'

  before_filter :load_recipe, only: [:edit, :update]

  def index
    @recipes = Recipe.pending
  end

  def new
    @recipe = Recipe.new
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
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :text, :original_url, {images: []}, :state)
  end
end
