class Admin::FoodsController < ApplicationController
  layout 'admin'

  before_filter :load_food, only: [:show, :edit, :update]

  def index
    foods = Food.order('name ASC')
    if params[:letter]
      letter = params[:letter] + '%'

      foods = foods.where("name like ? OR plural_name like ?", letter, letter)
    end

    @foods = foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new food_params
    if @food.save
      redirect_to admin_foods_path, notice: t('.success')
    else
      flash[:alert] = @food.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def edit
  end

  def update
    if @food.update_attributes food_params
      redirect_to admin_foods_path, notice: t('.success')
    else
      flash[:alert] = @food.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  private

  def load_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :plural_name)
  end
end
