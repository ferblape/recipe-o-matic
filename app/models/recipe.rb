class Recipe < ActiveRecord::Base
  include State

  has_many :ingredients
end
