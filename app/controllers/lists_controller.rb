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

  def edit
  end

  def update
  end

  def delete
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def load_list
    @list = params[:id].present? ? List.find(params[:id]) : List.new
  end
end
