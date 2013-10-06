class RecipesController < ApplicationController
  def index
    @recipes = Recipe.published.order('created_at DESC')
  end

  def show
  end
end
