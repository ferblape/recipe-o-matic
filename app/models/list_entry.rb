class ListEntry < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :list

  before_save :set_position

  private

  def set_position
    self.position = list.recipes.length + 1
  end
end
