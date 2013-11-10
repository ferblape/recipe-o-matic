class ListsController < ApplicationController

  before_filter :load_list, only: [:new, :edit, :update, :show]

  def index
    @lists = List.sorted_by_creation
  end

  def show
  end

  def new
  end

  def create
    @list = List.new list_params
    if @list.save
      redirect_to edit_list_path(@list)
    else
      render 'new'
    end
  end

  def recipes
    @list = List.find(params[:id])
    if recipe = Recipe.find(params[:recipe_id])
      @list.recipes << recipe
    end

    respond_to do |format|
      format.html do
        render json: recipe.as_json.merge({href: recipe_path(recipe)}).to_json
      end
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def load_list
    @list = params[:id].present? ? List.find(params[:id]) : List.new
  end
end
